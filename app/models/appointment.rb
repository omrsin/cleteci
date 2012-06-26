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

class Appointment < ActiveRecord::Base
  attr_accessible :date, :time, :topic, :via, :contact_attributes
  belongs_to :contact
  accepts_nested_attributes_for :contact
  
  validates :contact_id, presence: true
  validates :date, presence: true
  validates :topic, presence: true
  validates :via, presence: true
  
  validates_date :date, on_or_after: Date.current
  
  default_scope order: 'appointments.created_at DESC'
end
