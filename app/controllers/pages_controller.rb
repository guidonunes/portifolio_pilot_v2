class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    # Limit and order holdings for better performance
    # Preload only what we need for the trending section
    @holdings = Holding.order(created_at: :desc).limit(50)
    @crypto_holdings = @holdings.where(asset_type: "crypto").last(5)
    @fiat_holdings = @holdings.where(asset_type: "fiat").sample(5)
    
    # Refresh prices for holdings with zero or nil prices in background
    # This ensures we always have fresh data
    @fiat_holdings.each do |holding|
      if holding.current_price.nil? || holding.current_price.zero?
        # Trigger a refresh (will be cached on next request)
        holding.fetch_current_price
      end
    end
  end

  def about
  end

  def profile
    @user = current_user
  end
end
