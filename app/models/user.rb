class User < ApplicationRecord
  has_secure_password
<<<<<<< HEAD

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
=======
  has_many :likes, dependent: :destroy
>>>>>>> 0ae8c69b0b4463c167568b981519d84011af1f83
end
