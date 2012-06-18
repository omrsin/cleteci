FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "example.user#{n}" } 
    password "foo123bar"
    password_confirmation "foo123bar"
  end
end
