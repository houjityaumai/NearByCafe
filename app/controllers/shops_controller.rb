class ShopsController < ApplicationController
  require 'nokogiri'
  require 'net/http'
  def index
  end

  def show
  end

  def position
    yahoo_key = "dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-"
    url = URI.parse("https://map.yahooapis.jp/search/local/V1/localSearch?appid=#{yahoo_key}&lat=35.665662327484&lon=139.73091159273&dist=1")
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port, use_ssl: true) do |http|
      http.request(req)
    end
    xml = Nokogiri::XML(ret.body)

    # 名前空間の定義
    namespace = {
      "YDF" => "http://olp.yahooapis.jp/ydf/1.0"
    }


    feature = xml.xpath("//YDF:Feature", namespace)
    info_array = []
    @shops = []

    feature.each do |f|
      info_array << [f.xpath("YDF:Name", namespace).text, f.xpath("YDF:Property/YDF:Address", namespace).text]
    end

    info_array.each do |f|
      @shops << Utils::Shop.new(f[0], f[1])
      logger.debug(f[0])
      logger.debug(f[1])
    end
    logger.debug(@shops)


    # logger.debug("-----------------------------------------")
    # logger.debug(feature)
    # logger.debug("-----------------------------------------")
  end

  def search
  end
end

# https://map.yahooapis.jp/search/local/V1/localSearch?appid=＜あなたのClient ID（アプリケーションID）＞&lat=35.665662327484&lon=139.73091159273&dist=3
# dj00aiZpPTBlMlZsNXRFck5nOSZzPWNvbnN1bWVyc2VjcmV0Jng9YjI-