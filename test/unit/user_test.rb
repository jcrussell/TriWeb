require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:workouts)
  should have_many(:workout_attendees)
  should have_many(:workout_comments)

  test "all fields must be set" do
    user = FactoryGirl.build(:user)
    user.name = ""
    assert user.invalid?
  end

  test "new user has no roles" do
    user = FactoryGirl.create(:user)
    User::ROLES_MASK.each do |role|
      assert !user.has_role?(role)
    end
  end
end
