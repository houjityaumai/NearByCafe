class Shop < ApplicationRecord
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    puts "------------------------------"
    likes.exists?(user_id: user.id) 
  end
end