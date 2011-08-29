FactoryGirl.define do
  factory :user do
    email                 "test@tester.com"
    password              "password"
    password_confirmation "password"
  end
end
