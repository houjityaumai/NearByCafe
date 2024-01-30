class ShopsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  protect_from_forgery except: :positionjs
  require 'net/http'
  require 'uri'
  require 'json'

  def index
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

  def show
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
    @shop = json["results"]["shop"]
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

end

# https://map.yahooapis.jp/search/local/V1/localSearch?appid=＜あなたのClient ID（アプリケーションID）＞&lat=35.665662327484&lon=139.73091159273&dist=3
# dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-