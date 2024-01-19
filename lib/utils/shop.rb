module Utils
  class Shop #ファイル名はそのままクラス名にする
    attr_accessor :name, :address, :img, :code
    def initialize(name, address, url, code)
      self.name = name
      self.address = address
      self.img = url
      self.code = code
    end
  end
end