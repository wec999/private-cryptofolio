class CoinsController < ApplicationController
  require 'open-uri'
  before_action :set_coin, only: [:show, :edit, :update, :destroy]

  def new
    @coin = Coin.new
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = current_user
    @coin.cmarketcap_id = @coin.listing_api_coinmarketcap(@coin.name)
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
  end

  private

  def set_coin
    @coin = Coin.find(params[:id])
  end

  def coin_params
    params.require(:coin).permit(:name,:quantity)
  end

  def price_dollar
    url = "https://www.dolar-colombia.com/en/"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    Float(html_doc.css('h1')[1].text.split[1].tr(',',''))
  end

end
