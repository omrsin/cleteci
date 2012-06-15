# encoding: utf-8

require 'spec_helper'

describe "User Pages" do
  
  subject { page }

	describe "index for all users" do
		let(:user) { FactoryGirl.create(:user) }
  	before { visit users_path }
  	
  	it { should have_selector('title', text: "CLETECI | Administrador") }
  	it { should have_selector('h1', text: "Usuarios") }
  	
  	describe "new user sign up" do
  		let(:submit) { "Crear Usuario" }
  		
  		describe "with invalid information" do
  			it "should not create a user" do
  				expect { click_button submit }.not_to change(User, :count)
  			end
  		end
  		
  		describe "with valid information" do
  			before do
  				fill_in "Usuario", with: "example.user"
  				fill_in "Contraseña", with: "foo123bar"
  				fill_in "Confirme la contraseña", with: "foo123bar"
  			end
  			
  			it "should create a user" do
  				expect { click_button submit }.to change(User, :count).by(1)
  			end
  		end
  	end
  end
  
end
