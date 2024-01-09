class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    length: {
      maximum: 50
    }
  validates :email,
    presence: true,
    length: {
      maximum: 100
    }
  validates :password_digest,
  length: {
    maximum: 300
  }
end
