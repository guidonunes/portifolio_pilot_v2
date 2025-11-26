class Holding < ApplicationRecord
  validates :name, :asset_type, :abbreviation, presence: true

  before_create :set_current_price

  def update_current_price
    self.current_price = fetch_current_price
    save!
    current_price
  end

  def fetch_current_price
    # Cache API calls for 5 minutes to reduce external requests
    # Use abbreviation only for cache key since id might be nil during before_create
    cache_key = "holding_price_#{abbreviation}"
    
    # Try to get from cache first (only if it's a valid positive number)
    cached_price = Rails.cache.read(cache_key)
    if cached_price.present? && cached_price.is_a?(Numeric) && cached_price > 0
      return cached_price
    end
    
    # If not in cache or cached value is invalid, fetch from API
    fresh_price = if asset_type == 'fiat'
      Brapi.price(abbreviation)
    else
      result = Cryptocompare::Price.full(abbreviation, 'BRL')
      result.dig('RAW', abbreviation.upcase, 'BRL', 'PRICE')&.to_f
    end
    
    # Only cache successful API responses (not nil or 0 or negative)
    if fresh_price.present? && fresh_price.is_a?(Numeric) && fresh_price > 0
      Rails.cache.write(cache_key, fresh_price, expires_in: 5.minutes)
      # Update database if we have a valid price and it's different
      if persisted? && (current_price.nil? || current_price.zero? || (current_price - fresh_price).abs > 0.01)
        update_column(:current_price, fresh_price)
      end
      fresh_price
    else
      # If API fails, fallback to database value (might be stale but better than 0)
      # Only return 0 if database also has no value
      db_price = persisted? ? current_price : nil
      db_price.present? && db_price > 0 ? db_price : 0
    end
  end

  def find_percentage_holding_info
    # Cache API calls for 5 minutes to reduce external requests
    # Use abbreviation only for cache key since id might be nil during before_create
    cache_key = "holding_percentage_#{abbreviation}"
    
    # Try to get from cache first (only if it's a valid number)
    cached_percentage = Rails.cache.read(cache_key)
    if cached_percentage.present? && cached_percentage.is_a?(Numeric)
      return cached_percentage
    end
    
    # If not in cache, fetch from API
    fresh_percentage = if asset_type == 'fiat'
      Brapi.variation(abbreviation)
    else
      result = Cryptocompare::Price.full(abbreviation, 'BRL')
      result.dig('RAW', abbreviation.upcase, 'BRL', 'CHANGEPCT24HOUR')&.to_f
    end
    
    # Only cache successful API responses (not nil)
    if fresh_percentage.present? && fresh_percentage.is_a?(Numeric)
      Rails.cache.write(cache_key, fresh_percentage, expires_in: 5.minutes)
      fresh_percentage
    else
      # If API fails, return 0 but don't cache it
      0
    end
  end

  private

  def set_current_price
    self.current_price = fetch_current_price
  end
end
