module LikesHelper
  def liked_by?(user)
    likes.exists?(user_id: user.id) 
  end
end
