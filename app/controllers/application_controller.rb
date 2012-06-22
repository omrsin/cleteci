# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  private

    def logged_in_user
      redirect_to root_path, notice: "Dirección inválida" unless logged_in?
    end
end
