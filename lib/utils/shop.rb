module Utils
  class Shop #ファイル名はそのままクラス名にする
    attr_accessor :name, :address, :img
    def initialize(name, address, url)
      self.name = name
      self.address = address
      self.img = url
    end
  end
end