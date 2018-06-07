class Coin < ApplicationRecord
  belongs_to :user

  def listing_api_coinmarketcap(name)
    url = "https://api.coinmarketcap.com/v2/listings/"
    response = RestClient.get(url)
    data = JSON.parse (response)
    selection = data["data"].select { |position| position["website_slug"] == name.downcase }
    id = selection[0]["id"]
  end

  def price(coinmarketcap_id)
    url = "https://api.coinmarketcap.com/v2/ticker/#{coinmarketcap_id}/"
    response = RestClient.get(url)
    data = JSON.parse (response)
    price = data["data"]["quotes"]["USD"]["price"]
  end

end
