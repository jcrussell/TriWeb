require 'test_helper'

class WorkoutAttendeeTest < ActiveSupport::TestCase

  test "all fields must be set" do
    attendee = WorkoutAttendee.new
    assert attendee.invalid?
    assert attendee.errors[:likelihood].any?
  end

  test "likelihood must be in range" do
    attendee = FactoryGirl.create(:workout_attendee)
    assert attendee.valid?
    attendee.likelihood = 0
    assert attendee.invalid?
    attendee.likelihood = 101
    assert attendee.invalid?
    attendee.likelihood = 50
    assert attendee.valid?
  end
end
