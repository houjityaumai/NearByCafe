class ShopsController < ApplicationController
  require 'nokogiri'
  require 'net/http'
  def index
  end

  def show
  end

  def position
    yahoo_key = "dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-"
    url = URI.parse("https://map.yahooapis.jp/search/local/V1/localSearch?appid=#{yahoo_key}&lat=35.665662327484&lon=139.73091159273&dist=3")
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port, use_ssl: true) do |http|
      http.request(req)
    end
    xml = Nokogiri::XML(ret.body)
    logger.debug(xml)
  end

  def search
  end
end

# https://map.yahooapis.jp/search/local/V1/localSearch?appid=＜あなたのClient ID（アプリケーションID）＞&lat=35.665662327484&lon=139.73091159273&dist=3
# dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-