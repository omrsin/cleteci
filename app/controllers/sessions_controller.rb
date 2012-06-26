# encoding: utf-8

class SessionsController < ApplicationController
	
	def new
		
	end
	
	def create
		user = User.find_by_username(params[:session][:username])
		if user && user.authenticate(params[:session][:password])
		  login user
		  redirect_to appointments_path
		else
		  flash.now[:error] = 'Usuario/Contraseña inválidos'
      render 'new'
		end
	end

	def destroy
		logout
		redirect_to admin_path		
	end
end
