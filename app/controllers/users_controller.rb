class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @likes = []
    @user.likes.each do |like|
      yahoo_key = "64021912cf2b3b35"
    url = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/")
    url.query = URI.encode_www_form({
      key: yahoo_key,
      id: like.shopid,
      format: 'json'
    })
    req = Net::HTTP::Get.new(url.request_uri)
    ret = Net::HTTP::start(url.host, url.port) do |http|
      http.request(req)
    end
    json = JSON.parse(ret.body)
    # logger.debug(json["results"]["shop"])
    
    json["results"]["shop"].each do |shop|
      @likes << Utils::Shop.new(shop["name"], shop["address"], shop["photo"]["pc"]["l"], shop["id"])    
    end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_user)
    if @user.save
      log_in(@user)
      redirect_to shops_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(get_user)
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to shops_path
  end

  private
  def get_user
    params.require(:user).permit(:name, :email, :password)
  end

end
