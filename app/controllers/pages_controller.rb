class PagesController < ApplicationController
  def home
    @address = "1Chain4asCYNnLVbvG6pgCLGBrtzh4Lx4b"
    url = "https://api-r.bitcoinchain.com/v1/address/utxo/#{@address}"
    response = RestClient.get(url)
    @data = JSON.parse(response)
  end
end
