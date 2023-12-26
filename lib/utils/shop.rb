module Utils
  class Shop #ファイル名はそのままクラス名にする
    attr_accessor :name, :address
    def initialize(name, address)
      self.name = name
      self.address = address
    end
  end
end