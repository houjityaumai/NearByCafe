class ShopsController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  def index
  end

  def show
  end

  def position
  end

  def search
  end
end
