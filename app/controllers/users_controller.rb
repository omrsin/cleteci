# encoding: utf-8

class UsersController < ApplicationController
	before_filter :logged_in_user

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
    	flash[:success] = "Yay! Hay un nuevo admistrador."
    	redirect_to users_path
    else
    	@users = User.all
    	render 'index'
    end
  end
  
  def edit
  	@user = User.find(params[:id])
  end
  
  def update
  	@user = User.find(params[:id])
  	if (@user==current_user) && @user.update_attributes(params[:user])
  		flash[:success] = "Yawiiiii!!!! Usuario modificado!"
  		login(@user)
  		redirect_to users_path
  	elsif (@user!=current_user) && @user.update_attributes(params[:user])
  		flash[:success] = "Yawiiiii!!!! Usuario modificado!"
  		redirect_to users_path
  	else
  		render 'edit'
  	end
  end
  
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "Buuuuuu! Eliminaste a un usuario!"
  	redirect_to users_path
  end
  
  private

    def logged_in_user
      redirect_to root_path, notice: "Dirección inválida" unless logged_in?
    end
end
