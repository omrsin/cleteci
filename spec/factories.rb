FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "example.user#{n}" } 
    password "foo123bar"
    password_confirmation "foo123bar"
  end
  
  factory :contact do
  	name "Example"
  	lastname "Contact"
  	email "example@contact.com"
  	skypeid "example.contact"
  	phone "01234567890"
  	wish_info true
  end
  
  factory :appointment do
  	topic "This is a test topic"
  	date Date.current()
  	time "Between 2 and 3"
  	via "Email"
  	contact
  end
end
