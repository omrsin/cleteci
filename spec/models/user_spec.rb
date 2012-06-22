# encoding: utf-8

# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do
	before { @user = User.new(username: "example.user", password: "foo123bar",
														password_confirmation: "foo123bar") }
	
	subject { @user }
	 													 
	it { should respond_to(:username) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	
	it { should respond_to("authenticate") }
	
	it { should be_valid }
	
	describe "when username" do
		describe "is not present" do
			before { @user.username = " " }
			it { should_not be_valid }
		end
		
		describe "is too short" do
			before { @user.username = "a"*5 }
			it { should_not be_valid }
		end
		
		describe "is too long" do
			before { @user.username = "a"*31 }
			it { should_not be_valid }
		end
		
		describe "has wrong format" do
			it "should be invalid" do
				usernames = %w[foo@barbaz foo????bar foo123~bar foobárbaz]		
		    usernames.each do |invalid_username|
		    	@user.username = invalid_username
		      @user.should_not be_valid
      	end
			end
		end
		
		describe "has right format" do
			it "should be valid" do
				usernames = %w[foo.barbaz foo123_bar foo123-bar foobarbaz]		
		    usernames.each do |valid_username|
		    	@user.username = valid_username
		      @user.should be_valid
      	end
			end
		end
		
		describe "is already present" do
			before do
      	user_with_same_username = @user.dup
      	user_with_same_username.username = @user.username.upcase
      	user_with_same_username.save
    	end

    	it { should_not be_valid }
		end
	end
	
	describe "when password" do
		describe "is not present" do
			before { @user.password = @user.password_confirmation = " " }
			it { should_not be_valid }
		end
		
		describe "doesn't match the password confirmation" do
			before { @user.password_confirmation = "mismatch" }
			it { should_not be_valid }
		end
		
		describe "is too short" do
			before { @user.password = @user.password_confirmation = "a"*5 }
			it { should_not be_valid }
		end
		
		describe "is too long" do
			before { @user.password = @user.password_confirmation = "a"*31 }
			it { should_not be_valid }
		end
		
		describe "has wrong format" do
			it "should be invalid" do
				passwords = %w[foobarbaz 123456789 fóobarbaz]		
		    passwords.each do |invalid_password|
		    	@user.password = @user.password_confirmation = invalid_password
		      @user.should_not be_valid
      	end
			end
		end
		
		describe "has right format" do
			it "should be valid" do
				passwords = %w[foo123baz 123foo789 foo$4?baz]		
		    passwords.each do |valid_password|
		    	@user.password = @user.password_confirmation = valid_password
		      @user.should be_valid
      	end
			end
		end
	end
	
	describe "when password confirmation" do
		describe "is nil" do
			before { @user.password_confirmation = nil }
			it { should_not be_valid }
		end
	end
	
	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_username(@user.username) }

		describe "with valid password" do
		  it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
		  let(:user_for_invalid_password) { found_user.authenticate("invalid") }

		  it { should_not == user_for_invalid_password }
		  specify { user_for_invalid_password.should be_false }
		end
	end
	
	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }	
	end
	
end
