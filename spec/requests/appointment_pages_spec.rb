# encoding: utf-8

require 'spec_helper'

describe "Appointment Pages" do

	subject { page }

	describe "index" do
		let(:user) { FactoryGirl.create(:user) }
		let(:contact) { FactoryGirl.create(:contact) }
		let(:appointment) { FactoryGirl.create(:appointment, contact: contact) }
  	before do
  		login(user)
  		contact.save
  		appointment.save
  		visit appointments_path 
  	end
  	
  	it { should have_selector('title', text: "CLETECI | Administrador") }  	
  	it { should have_selector('h1', text: "Citas") }
  	it { should have_content(contact.name) }
  	it { should have_content(appointment.topic) }
  	it { should have_content(appointment.date) }
  	it { should have_content(appointment.time) }
  	it { should have_content(appointment.via) }
  	it { should have_content(contact.appointments.count) }  	
  end
end
