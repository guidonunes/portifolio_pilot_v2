class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home
    # Limit and order holdings for better performance
    # Preload only what we need for the trending section
    @holdings = Holding.order(created_at: :desc).limit(50)
    @crypto_holdings = @holdings.where(asset_type: "crypto").last(5)
    @fiat_holdings = @holdings.where(asset_type: "fiat").sample(5)
  end

  def about
  end

  def profile
    @user = current_user
  end
end
