class Shop < ApplicationRecord
  def liked_by?(user)
    likes.exists?(user_id: user.id) 
  end
end