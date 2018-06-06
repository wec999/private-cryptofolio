class CoinsController < ApplicationController
  before_action :set_coin, only: [:show, :edit, :update, :destroy]

  def new
    @coin = Coin.new
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = current_user
    @coin.cmarketcap_id = @coin.listing_api_coinmarketcap(@coin.name)
    if @coin.save!
      redirect_to coin_path(@coin)
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
  end

  def show

    url = "https://api.coinmarketcap.com/v2/ticker/#{@coin.cmarketcap_id}/"
    response = RestClient.get(url)
    data = JSON.parse (response)
    @price = data["data"]["quotes"]["USD"]["price"]

  end

  private

  def set_coin
    @coin = Coin.find(params[:id])
  end

  def coin_params
    params.require(:coin).permit(:name,:quantity)
  end


end
