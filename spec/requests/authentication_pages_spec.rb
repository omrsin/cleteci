# encoding: utf-8

require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "admin login page" do
  	before { visit admin_path }
  	
  	it { should have_selector('title', text: "Administrador") }
  	
  	describe "login with invalid information" do
  		before { click_button "Iniciar Sesión" }
  		
  		it { should have_selector('div.alert.alert-error', text: 'inválidos') }
  		
  		describe "after visiting another page" do
        before { click_link "INICIO" }
        it { should_not have_selector('div.alert.alert-error') }
      end
  	end
  	
  	describe "login with valid information" do
  		let(:user) { FactoryGirl.create(:user) }
  		before { login(user) } 
  		
  		it { should have_link('USUARIOS', href: users_path) }
  		it { should have_link('CITAS', href: appointments_path ) }
  		it { should have_link('SALIR', href: logout_path) }
  		it { should have_link(user.username, href: edit_user_path(user)) }
  		
  		describe "followed by logout" do
  			before { click_link "SALIR" }
  			it { should_not have_link('USUARIOS', href: logout_path) }
  			it { should_not have_link('CITAS', href: appointments_path ) }
  			it { should_not have_link('SALIR', href: logout_path) }
  		end
  	end
  end
  
  describe "authorization" do
  	let(:user) { FactoryGirl.create(:user) }
  	let(:appointment) { FactoryGirl.create(:appointment) }
  	
  	describe "in the Users controller" do
  		before { put user_path(user) }
  		specify { response.should redirect_to(root_path) }
  	end
  end
  
  describe "without logging in" do
		let(:user) { FactoryGirl.create(:user) }
		let(:another_user) { FactoryGirl.create(:user) }
	 
		describe "submitting a delete request" do
	  	before { delete user_path(another_user) }
    	specify { response.should redirect_to(root_path) } 
		end
  end
end
