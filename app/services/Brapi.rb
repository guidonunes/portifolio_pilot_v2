class Brapi
  BASE_URL = "https://brapi.dev/api/quote"

  def self.price(abbreviation)
    return nil if abbreviation.blank?
    
    # Use token parameter as per Brapi API documentation
    token_param = ENV['Brapi_API_KEY'].present? ? "?token=#{ENV['Brapi_API_KEY']}" : ""
    url = "#{BASE_URL}/#{abbreviation}#{token_param}"
    
    begin
      result = HTTParty.get(url, timeout: 10)
      
      unless result.success?
        Rails.logger.error "Brapi API error for #{abbreviation}: #{result.code} - #{result.message}"
        return nil
      end
      
      stock_data = result['results']&.first
      
      if stock_data && stock_data['regularMarketPrice']
        stock_data['regularMarketPrice'].to_f
      else
        Rails.logger.warn "Brapi: No price data found for #{abbreviation}"
        nil
      end
    rescue => e
      Rails.logger.error "Brapi API exception for #{abbreviation}: #{e.message}"
      nil
    end
  end

  def self.variation(abbreviation)
    return nil if abbreviation.blank?
    
    # Use token parameter as per Brapi API documentation
    token_param = ENV['Brapi_API_KEY'].present? ? "?token=#{ENV['Brapi_API_KEY']}" : ""
    url = "#{BASE_URL}/#{abbreviation}#{token_param}"
    
    begin
      result = HTTParty.get(url, timeout: 10)
      
      unless result.success?
        Rails.logger.error "Brapi API error for #{abbreviation}: #{result.code} - #{result.message}"
        return nil
      end
      
      stock_data = result['results']&.first
      
      if stock_data && stock_data['regularMarketChangePercent']
        stock_data['regularMarketChangePercent'].to_f
      else
        Rails.logger.warn "Brapi: No variation data found for #{abbreviation}"
        nil
      end
    rescue => e
      Rails.logger.error "Brapi API exception for #{abbreviation}: #{e.message}"
      nil
    end
  end
end
