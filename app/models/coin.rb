class Coin < ApplicationRecord
  belongs_to :user

  def api_coinmarketcap(name)
    array = []
    url = "https://api.coinmarketcap.com/v2/listings/"
    response = RestClient.get(url)
    data = JSON.parse (response)
    selection = data["data"].select { |position| position["website_slug"] == name.downcase }
    id = selection[0]["id"]
    symbol = selection[0]["symbol"]
    array.push(id, symbol)
  end

  def price(coinmarketcap_id)
    url = "https://api.coinmarketcap.com/v2/ticker/#{coinmarketcap_id}/"
    response = RestClient.get(url)
    data = JSON.parse (response)
    price = data["data"]["quotes"]["USD"]["price"]
  end

  def api_bittrex
    url = "https://bittrex.com/api/v1.1/public/getticker?market=BTC-#{self.symbol}"
    response = RestClient.get(url)
    data = JSON.parse (response)
  end

  def api_cryptopia
    url = "https://www.cryptopia.co.nz/api/GetMarket/#{self.symbol}_BTC"
    response = RestClient.get(url)
    data = JSON.parse (response)
  end

  def api_binance
    name = self.name.upcase
    url = "https://api.binance.com/api/v3/ticker/bookTicker?symbol=#{symbol}BTC"
    response = RestClient.get(url)
    data = JSON.parse (response)
  end


end
