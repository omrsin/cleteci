# encoding: utf-8

# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  lastname   :string(255)     not null
#  email      :string(255)     not null
#  skypeid    :string(255)
#  phone      :string(255)
#  wish_info  :boolean         default(TRUE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Contact do
  
  before { @contact = Contact.new(name: "Example", 
  																lastname: "Contact", 
  																email: "user@example.com",
  																skypeid: "user.contact",
  																phone: "01234567890",
  																wish_info: true) }
  subject { @contact }
  
  it { should respond_to(:name) }
  it { should respond_to(:lastname) }
  it { should respond_to(:email) }
  it { should respond_to(:skypeid) }
  it { should respond_to(:phone) }
  it { should respond_to(:wish_info) }
  it { should respond_to(:appointments) }
  
  it { should be_valid }
  
  describe "when name" do
  	describe "is not present" do
			before { @contact.name = "  " }
			it { should_not be_valid }
		end
		
		describe "is too long" do
			before { @contact.name = "a"*26 }
			it { should_not be_valid }
		end
  end
  
  describe "when lastname" do
  	describe "is not present" do
  		before { @contact.lastname = "  " }
			it { should_not be_valid }
		end
		
		describe "is too long" do
			before { @contact.lastname = "a"*26 }
			it { should_not be_valid }
		end
  end
  
  describe "when email" do
  	describe "is not present" do
			before { @contact.email = "  " }
			it { should_not be_valid }
		end
		
		describe "has wrong format" do
			it "should be invalid" do
				addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]		
		    addresses.each do |invalid_address|
		    	@contact.email = invalid_address
		      @contact.should_not be_valid
      	end
			end
		end
		
		describe "has right format" do
			it "should be valid" do
				addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
		    addresses.each do |valid_address|
		    	@contact.email = valid_address
		      @contact.should be_valid
      	end
			end
		end
		
		describe "is duplicated" do
			before do
				contact_with_same_email = @contact.dup
				contact_with_same_email.save				
			end
			it "should raise an error" do
				expect { @contact.save }.to raise_error(ActiveRecord::RecordNotUnique)			
			end
		end
  end
  
  describe "when skypeid" do
  	describe "is null" do
  		before { @contact.skypeid = nil }
  		it { should be_valid }
  	end
  	  
  	describe "is too long" do
  		before { @contact.skypeid = "a"*33 }
  		it { should_not be_valid }
  	end
  	
  	describe "is too short" do
  		before { @contact.skypeid = "a"*5 }
  		it { should_not be_valid }
  	end
  	
  	describe "has wrong format" do
			it "should be invalid" do
				skypeids = %w[1foobar foo*bar foo.bar#]		
		    skypeids.each do |invalid_skypeid|
		    	@contact.skypeid = invalid_skypeid
		      @contact.should_not be_valid
      	end
			end
		end
		
		describe "has right format" do
			it "should be valid" do
				skypeids = %w[foobar1 foo.bar foo__,bar]	
		    skypeids.each do |valid_skypeid|
		    	@contact.skypeid = valid_skypeid
		      @contact.should be_valid
      	end
			end
		end
  end
  
  describe "when phone" do
  	describe "is null" do
  		before { @contact.phone = nil }
  		it { should be_valid }
  	end
  
  	describe "is too long" do
  		before { @contact.phone = "1"*12 }
  		it { should_not be_valid }
  	end
  	
  	describe "is too short" do
  		before { @contact.phone = "1"*10 }
  		it { should_not be_valid }
  	end
  	
  	describe "has wrong format" do
			it "should be invalid" do
				phones = %w[1234fg78901 12345#78901 *2345678901 +2345678901]		
		    phones.each do |invalid_phone|
		    	@contact.phone = invalid_phone
		      @contact.should_not be_valid
      	end
			end
		end
		
		describe "has right format" do
			it "should be valid" do
				phones = %w[12345678901 04125879636]	
		    phones.each do |valid_phone|
		    	@contact.phone = valid_phone
		      @contact.should be_valid
      	end
			end
		end
  end
  
  describe "appointments associations" do
  	before { @contact.save }
  	let!(:older_appointment) { FactoryGirl.create(:appointment, contact: @contact, created_at: 1.day.ago) }
  	let!(:newer_appointment) { FactoryGirl.create(:appointment, contact: @contact, created_at: 1.hour.ago) }
  
		it "should have the right appointments in the right order" do
			@contact.appointments.should == [newer_appointment, older_appointment]
		end    
  end   
end
