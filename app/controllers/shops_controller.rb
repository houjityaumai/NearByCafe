class ShopsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  protect_from_forgery except: :positionjs
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      lat: params[:latitude],
      lng: params[:longitude],
      range: 5 ,
      genre: 'G014', # カフェを選択
      count: 20,
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    # logger.debug(json["results"]["shop"])
    @shops = []
    json["results"]["shop"].each do |shop|
      @shops << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"], shop["id"])    
    end

    logger.debug(@shops)
  end

  def location
    respond_to do |format|
      format.js
    end
  end

  def show
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      id: params[:id],
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    @shop = []
    @shop = json["results"]["shop"]
    logger.debug(@shop)
  end

  # todo showを作成する

  def positionjs
    respond_to do |format|
      format.js
    end
  end

  def position
    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      lat: params[:latitude],
      lng: params[:longitude],
      range: params[:range],
      genre: 'G014', # カフェを選択
      count: 20,
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    logger.debug(json["results"]["shop"])
    @shops = []
    json["results"]["shop"].each do |shop|
      @shops << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"], shop["id"])
    end
  end

  def search
    @prefectures = Prefecture.all
    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      keyword: params[:keyword],
      range: 5 ,
      genre: 'G014', # カフェを選択
      count: 20,
      large_area: params[:large_area],
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    # logger.debug(json["results"]["shop"])
    @shops = []
    json["results"]["shop"].each do |shop|
      @shops << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"], shop["id"])    
    end
  end

  def like
    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      lat: params[:latitude],
      lng: params[:longitude],
      range: 5 ,
      genre: 'G014', # カフェを選択
      count: 20,
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    # logger.debug(json["results"]["shop"])
    @shops = []
    json["results"]["shop"].each do |shop|
      @shops << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"], shop["id"])    
    end
  end

  def create
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    # logger.debug(@current_user)
    # logger.debug(@current_user.name)
    if logged_in?
      like = Like.new(user: current_user, shopid: params[:id])
      logger.debug(like)
      like.save!
      redirect_to shop_path(params[:id])
    else
      redirect_to "/login"
    end
  end

  def destroy
    like = Like.find_by(user_id: @current_user.id, shopid: params[:id])
    logger.debug("-------------------------")
    logger.debug(like)
    like.destroy
    redirect_to shop_path(params[:id])
  end

  private

  def get_lat_and_lon
    # latitude:緯度、longitude:経度
    return {latitude: params[:latitude],
              longitude: params[:longitude]}
  end
end

# https://map.yahooapis.jp/search/local/V1/localSearch?appid=＜あなたのClient ID（アプリケーションID）＞&lat=35.665662327484&lon=139.73091159273&dist=3
# dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-