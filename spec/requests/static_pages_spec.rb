# encoding: utf-8

require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do
  	before { visit root_path }
    it { should have_selector('title', text: "CLETECI") }
  end
  
  describe "Contact page" do
  	before { visit new_contact_path }
  	it { should have_selector('title', text: 'Contáctanos') }
  	
  	describe "new appointment" do
  		let(:submit) { "Enviar" }
  		
  		describe "with invalid information" do
  			it "should not create an appointment" do
  				expect { click_button submit }.not_to change(Appointment, :count)
  			end
  			it "should not create a contact" do
  				expect { click_button submit }.not_to change(Contact, :count)
  			end
  		end
  		
  		describe "with valid data" do
  			before do
  				fill_in "Nombre", with: "Example"
  				fill_in "Apellido", with: "Contact"
  				fill_in "Correo", with: "example@contact.com"
  				fill_in "SkypeID", with: "example.contact"
  				fill_in "Teléfono", with: "01234567890"
  				check "Desea recibir información"  				
  			end
  			
  			it "should create a contact" do
  				expect { click_button submit }.to change(Contact, :count).by(1)
  			end
  		end
  	end
  end  
end
