class Coin < ApplicationRecord
  belongs_to :user

  def listing_api_coinmarketcap
    url = "https://api.coinmarketcap.com/v2/listings/"
    response = RestClient.get(url)
    @data = JSON.parse (response)
  end

end
