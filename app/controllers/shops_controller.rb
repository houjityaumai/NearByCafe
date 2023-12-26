class ShopsController < ApplicationController
  protect_from_forgery except: :positionjs
  require 'net/http'
  require 'uri'
  require 'json'

  def index
  end

  def show
  end

  def positionjs
    respond_to do |format|
      format.js
    end
    # render formats: :js
    # render "positionjs.js.erb", content_type: "text/javascript"
  end

  def position

    position = get_lat_and_lon #緯度経度を取得
    p "------------------------"
    p params[:latitude]
    p params[:longitude]
    p 35.4615296
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
    logger.debug(json["results"]["shop"])
    @shops = []
    json["results"]["shop"].each do |shop|
      @shops << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"])
    end
  end

  def search
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