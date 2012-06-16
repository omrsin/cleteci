# encoding: utf-8

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  username   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_secure_password
  
	before_save { |user| user.username = username.downcase }
	before_save :create_remember_token
  
  VALID_USERNAME_REGEXP = /\A[\w+\-.]*\z/i
  VALID_PASSWORD_REGEXP = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){6,}$/
  
  validates :username, presence: true, 
  										 length: { within: (6..30) }, 
  										 format: { with: VALID_USERNAME_REGEXP },
  										 uniqueness: { case_sensitive: false } 
  validates :password, length: { within: (6..30), 
  															 too_long: "es demasiado larga (máximo %{count} caracteres)",
  															 too_short: "es demasiado corta (mínimo %{count} caracteres)"  }, 
  										 format: { with: VALID_PASSWORD_REGEXP,
  										 					 message: "es inválida (debe incluir letras y números" }
  validates :password_confirmation, presence: true
  
  private
  	
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end
end
