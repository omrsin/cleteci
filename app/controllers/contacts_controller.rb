class ContactsController < ApplicationController
  before_filter :logged_in_user
  
  def new
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
end
