class AppointmentsController < ApplicationController

	def index
		@appointments = Appointment.page(params[:page]).per_page(5)
		@appointments_count = Appointment.count
	end	
end
