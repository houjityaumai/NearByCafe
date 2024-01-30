class LikesController < ApplicationController
  
  def create
    shop = Shop.find(params[:shop_id])
    like = current_user.likes.new(shop_id: shop.id)
    like.save
    redirect_to likes_path(params[:id])
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    like = current_user.likes.find_by(shop_id: shop.id)
    like.destroy
    redirect_to shops_path
  end
end
