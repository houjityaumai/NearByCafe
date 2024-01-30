class Like < ApplicationRecord
  belongs_to :user
  def liked_by?(user)
    Like.exists?(user_id: user.id) 
  end
  
end
