class Like < ApplicationRecord
  belongs_to :user
  def liked_by?(user)
    likes.exists?(user_id: user.id) 
  end
end
