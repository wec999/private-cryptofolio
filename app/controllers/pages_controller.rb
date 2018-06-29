require 'open-uri'

class PagesController < ApplicationController
  def index
    @address = "1Chain4asCYNnLVbvG6pgCLGBrtzh4Lx4b"
    url = "https://api-r.bitcoinchain.com/v1/address/utxo/#{@address}"
    response = RestClient.get(url)
    @data = JSON.parse(response)
    @price_dollar = price_dollar
    id = api_coinmarketcap("bitcoin")
    @price_coin = price (id[0])
    @price_buy_localbitcoin = api_localbitcoins_buy
    @price_sell_localbitcoin = api_localbitcoins_sell
  end

  def home
     @price_buy_localbitcoin = api_localbitcoins_buy
     @price_sell_localbitcoin = api_localbitcoins_sell
  end

  def show

  end

  private

  def price_dollar
    precios = []
    url = "https://www.dolar-colombia.com/en/"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    compra = Float(html_doc.css('strong')[0].text.split[1].tr(',',''))
    venta = Float(html_doc.css('strong')[1].text.split[1].tr(',',''))
    trm = Float(html_doc.css('h1')[1].text.split[1].tr(',',''))
    precios.push(compra, venta, trm)
  end

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

  def api_localbitcoins_buy
    url = "https://localbitcoins.com//buy-bitcoins-online/cop/.json"
    response = RestClient.get(url)
    data = JSON.parse(response)
    price = data["data"]["ad_list"][0]["data"]["temp_price"]
  end

  def api_localbitcoins_sell
    url = "https://localbitcoins.com//sell-bitcoins-online/cop/.json"
    response = RestClient.get(url)
    data = JSON.parse(response)
    price = data["data"]["ad_list"][0]["data"]["temp_price"]
  end

end
