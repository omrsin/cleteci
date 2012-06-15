FactoryGirl.define do
  factory :user do
    username     "example.user"
    password "foo123bar"
    password_confirmation "foo123bar"
  end
end
