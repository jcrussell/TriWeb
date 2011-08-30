FactoryGirl.define do
  factory :workout do
    name        "Test Workout"
    description "This is a test workout."
    what        "Swim"
    time        { DateTime.now.end_of_day }
  end
end
