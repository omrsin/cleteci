# encoding: utf-8

require 'spec_helper'

describe "ContactPages" do
	
	subject { page }
	
  describe "index" do
		after(:all) do
			Appointment.delete_all
			Contact.delete_all   		
		end
		
		let(:user) { FactoryGirl.create(:user) }
		let(:contact1) { FactoryGirl.create(:contact) }
		let(:contact2) { FactoryGirl.create(:contact) }
		before do
			login user
			contact1.save
			contact2.save
			visit contacts_path
		end
		
		it { should have_selector('title', text: "CLETECI | Administrador") }
		it { should have_selector('h1', text: "Contactos") }
		it { should have_content(contact1.name) }
		it { should have_content(contact1.lastname) }
		it { should have_content(contact1.email) }
		it { should have_content(contact1.skypeid) }
		it { should have_link("#{contact1.name} #{contact1.lastname}", href: contact_path(contact1)) }
		it { should have_content(contact1.phone) }
		it { should have_content(contact2.lastname) }
		it { should have_content(contact2.email) }
		it { should have_content("Número de contactos: #{Contact.count}") }
  	
  end
end
