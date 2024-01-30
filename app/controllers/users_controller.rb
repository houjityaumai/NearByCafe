class UsersController < ApplicationController
  def index
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    @user = User.new
  end

  def create
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    @user = User.new(get_user)
    if @user.save
      log_in(@user)
      redirect_to users_path
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

  def login
  end

  def logout
  end

  private
  def get_user
    params.require(:user).permit(:name, :email, :password)
  end

end
