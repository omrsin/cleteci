class UsersController < ApplicationController
  def new
  end
  
  def show
  	@user = User.find(params[:id])
  end
  
  def index
  	@users = User.all
  	@user = User.new
  end
  
  def create
  	@user = User.new(params[:user])
    if @user.save
    	flash[:success] = "Yay! Hay un nuevo admiistrador."
    	redirect_to users_path
    else
    	@users = User.all
    	render 'index'
    end
  end
end
