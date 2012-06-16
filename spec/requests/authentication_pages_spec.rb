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
  		before do
  			fill_in "Usuario", with: user.username
  			fill_in "Contraseña", with: user.password
  			click_button "Iniciar Sesión"
  		end
  		
  		it { should_not have_link('USUARIOS', href: logout_path) }
  		it { should have_link('SALIR', href: logout_path) }
  		
  		describe "followed by logout" do
  			before { click_link "SALIR" }
  			it { should_not have_link('USUARIOS', href: logout_path) }
  			it { should_not have_link('SALIR', href: logout_path) }
  		end
  	end
  end
end
