# encoding: utf-8

require 'spec_helper'

describe "User Pages" do
  
  subject { page }

	describe "index for all users" do
		let(:user) { FactoryGirl.create(:user) }
  	before do 
  		login(user)
  		visit users_path
  	end
  	
  	it { should have_selector('title', text: "CLETECI | Administrador") }
  	it { should have_selector('h1', text: "Usuarios") }
  	it { should_not have_link("Eliminar", href: user_path(user)) }
  	
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
  	
  	describe "delete links" do
			let(:another_user) { FactoryGirl.create(:user) }
			before do
				click_link "SALIR"
				login(another_user)
				visit users_path
			end
			
			it { should have_link("Eliminar", href: user_path(user)) }
			
			it "should be able to delete another user" do
				expect { click_link("Eliminar") }.to change(User, :count).by(-1)
			end
			
			describe "Removing links" do
				before { click_link("Eliminar") }
				it { should_not have_link("Eliminar", href: user_path(user)) }				
			end
		end
  end
  
  describe "edit" do
  	after(:all)  { User.delete_all }  
  	
  	let(:user) { FactoryGirl.create(:user) }
  	before do 
  		login(user)
  		visit edit_user_path(user) 
  	end
  	
  	describe "page" do
  		it { should have_selector('h1', text: "Modificar Usuario") }
  		it { should have_selector('title', text: "Administrador") }
  	end
  	
  	describe "with invalid information" do
  		before { click_button "Salvar Cambios" }
  		
  		it { should have_content('inválida') }
  	end
  	
  	describe "with valid information" do  		  		
  		let(:new_username) { "new.example.user" }
  		let(:new_password) { "foo123barbaz" } 				
  		describe "another user" do
  			let(:another_user) { FactoryGirl.create(:user)}
				before do
					visit edit_user_path(another_user)
					fill_in "Usuario", with: new_username
					fill_in "Contraseña", with: new_password
					fill_in "Confirme la contraseña", with: new_password
					click_button "Salvar Cambios"
				end
			  		
				it { should have_selector('div.alert.alert-success') }
				it { should have_link('SALIR', href: logout_path) }
		    specify { another_user.reload.username.should  == new_username }		   
		  end
		  
		  describe "a logged user" do		  	
		  	before do		  		
		  		visit edit_user_path(user)
					fill_in "Usuario", with: new_username
					fill_in "Contraseña", with: new_password
					fill_in "Confirme la contraseña", with: new_password
					click_button "Salvar Cambios"
		  	end
		  	
		  	it { should have_selector('div.alert.alert-success') }
				it { should have_link('SALIR', href: logout_path) }
		    specify {user.reload.username.should  == new_username }
		  end
  	end
  end
  
end
