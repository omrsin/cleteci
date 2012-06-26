class ContactsController < ApplicationController
  before_filter :logged_in_user
  
  def new
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
  
  def index
  	@contacts = Contact.page(params[:page]).per_page(15)
  	@contacts_count = Contact.count
  end
end
