class StaticPagesController < ApplicationController
  def home
  end
  
  def contact
  	@appointment = Appointment.new
  end
  
  def create_contact
  	@appointment = Appointment.new(params[:appointment])
  	@contact = Contact.find_by_email(params[:contact][:email])
  	if @contact.nil?
  		@contact = Contact.new(params[:contact])
#  		@contact.wish_info = params[:contact][:wish_info] == 1 ? true : false
  		@contact.save
  	else
  		@contact.update_attributes(params[:contact])
  	end  	
  	@appointment.contact = @contact
  	if @appointment.save
    	flash[:success] = "Ha registrado su cita exitosamente"
    	redirect_to new_contact_path
    else
    	render 'contact'
    end
  end
end
