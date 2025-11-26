class Brapi
  def self.price(abbreviation)
    url = "https://brapi.dev/api/quote/#{abbreviation}?apikey=#{ENV['Brapi_API_KEY']}"
    result = HTTParty.get(url)
    return nil unless result.success?
    stock_data = result['results']&.first

    stock_data ? stock_data['regularMarketPrice'].to_f : nil
  end

def self.variation(abbreviation)
    url = "https://brapi.dev/api/quote/#{abbreviation}?apikey=#{ENV['Brapi_API_KEY']}"

    result = HTTParty.get(url)

    return nil unless result.success?

    stock_data = result['results']&.first
    stock_data ? stock_data['regularMarketChangePercent'].to_f : nil
  end
end
