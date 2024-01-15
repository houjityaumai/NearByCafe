class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_secure_password
end
