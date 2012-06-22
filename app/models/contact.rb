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

class Contact < ActiveRecord::Base
  attr_accessible :email, :lastname, :name, :phone, :skypeid, :wish_info
  has_many :appointments
  
  before_save { |contact| contact.email = email.downcase }
  before_save { |contact| contact.skypeid = skypeid.downcase }
  
  VALID_SKYPEID_REGEX = /\A[a-zA-Z][\w+\-.,]*\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d*\z/i
    
  validates :name, presence: true, length: { maximum: 25 }
  validates :lastname, presence: true, length: { maximum: 25 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :skypeid, length: { within: 6..32 }, allow_nil: true, format: { with: VALID_SKYPEID_REGEX }
  validates :phone, length: { is: 11}, allow_nil: true, format: { with: VALID_PHONE_REGEX }
  validates :wish_info, presence: true
end
