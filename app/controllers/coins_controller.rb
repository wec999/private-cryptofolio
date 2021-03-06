class CoinsController < ApplicationController
  require 'open-uri'
  before_action :set_coin, only: [:show, :edit, :update, :destroy]

  def new
    @coin = Coin.new
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = current_user
    id_symbol_array = @coin.api_coinmarketcap(@coin.name)
    @coin.cmarketcap_id = id_symbol_array[0]
    @coin.symbol = id_symbol_array[1]
    if @coin.save!
      # redirect_to coin_path(@coin)
      redirect_to coins_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @coin.update(coin_params)
      redirect_to coin_path(@coin)
    else
      render :edit
    end
  end

  def destroy
    @coin.destroy
    redirect_to coins_path
  end

  def index
    @coins = Coin.all
    @price_dollar = price_dollar
  end

  def show
    @bittrex = @coin.api_bittrex
    @cryptopia = @coin.api_cryptopia
    @binance = @coin.api_binance
  end

  private

  def set_coin
    @coin = Coin.find(params[:id])
  end

  def coin_params
    params.require(:coin).permit(:name,:quantity)
  end

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

end
