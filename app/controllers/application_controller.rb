# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  include SessionsHelper
  
  private

    def logged_in_user
      redirect_to root_path, notice: "Dirección inválida" unless logged_in?
    end
    
    def set_locale
    	I18n.locale = "en"
    end
end
