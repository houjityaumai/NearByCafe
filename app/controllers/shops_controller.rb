class ShopsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def index
  end

  def show
  end

  def position
  




    yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      lat: 35.4622429,
      lng: 133.0664864,
      range: 5 ,
      genre: 'G014', # カフェを選択
      keyword: params[:keyword],
      large_area: params[:large_area],
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
      @shops << Utils::Shop.new(shop["name"], shop["address"])
    end

  end

  def search
  end
end

# https://map.yahooapis.jp/search/local/V1/localSearch?appid=＜あなたのClient ID（アプリケーションID）＞&lat=35.665662327484&lon=139.73091159273&dist=3
# dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-