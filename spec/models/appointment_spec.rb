# == Schema Information
#
# Table name: appointments
#
#  id         :integer         not null, primary key
#  topic      :text            not null
#  date       :date            not null
#  time       :string(255)
#  via        :string(255)     default("email"), not null
#  contact_id :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Appointment do
  let(:contact) { FactoryGirl.create(:contact) }
  before do
  	@appointment = contact.appointments.build(topic: "Appointment topic", date: Date.current(), 
  																 time: "Between 1 and 2", via: "Skype")
  end
  
  subject { @appointment }
  
  it { should respond_to(:topic) }
  it { should respond_to(:date) }
  it { should respond_to(:time) }
  it { should respond_to(:via) }
  it { should respond_to(:contact) }
  its(:contact) { should == contact }
  
  it { should be_valid }
  
  describe "accessible attributes" do
    it "should not allow access to contact_id" do
      expect do
        Appointment.new(contact_id: contact.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end
  
  describe "when date" do
  	describe "is not present" do
  		before { @appointment.date = nil }
  		it { should_not be_valid }
  	end
  	
  	describe "is before today" do
  		before { @appointment.date = Date.yesterday() }
  		it { should_not be_valid }
  	end
  end
  
  describe "when topic" do
  	describe "is not present" do
  		before { @appointment.topic = " " }
  		it { should_not be_valid }
  	end
  end
  
  describe "when via" do
  	describe "is not present" do
  		before { @appointment.via = " " }
  		it { should_not be_valid }
  	end
  end
  
  describe "when contact_id" do
  	describe "is not present" do
			before { @appointment.contact_id = nil }
			it { should_not be_valid }
		end
	end  
  
end
