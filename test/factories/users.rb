FactoryGirl.define do
  factory :user do
    name                  "test mctester"
    email                 "test@tester.com"
    password              "password"
    password_confirmation "password"
    confirmed_at          { DateTime.now }
  end
end
