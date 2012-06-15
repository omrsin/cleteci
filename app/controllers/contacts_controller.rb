class ContactsController < ApplicationController
  def new
  end
  
  def show
    @contact = Contact.find(params[:id])
  end
end
