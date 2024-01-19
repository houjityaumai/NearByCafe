class User < ApplicationRecord
  has_secure_password
  has_many :likes, dependent: :destroy

  validates :name,
    presence: true,
    length: {
      maximum: 50,
      allow_blank: true
    }
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: true
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password,
    length: { in: 8..16 },
    format: { with: VALID_PASSWORD_REGEX,
    message: "は8~16文字で入力する必要があります"},
    allow_nil: true
  
end
