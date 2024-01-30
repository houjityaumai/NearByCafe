class SessionsController < ApplicationController

  def new
    logger.debug("--------------------------")
    logger.debug(logged_in?)
    logger.debug(@current_user.name)
    @user = User.new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to shops_path
    else
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
