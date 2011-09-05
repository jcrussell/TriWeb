require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  should have_many(:workout_attendees)
  should have_many(:workout_comments)

  test "all fields must be set" do
    workout = Workout.new
    assert workout.invalid?
    assert workout.errors[:name].any?
    assert workout.errors[:description].any?
    assert workout.errors[:what].any?
    assert workout.errors[:time].any?
  end

  test "what must be in TYPES" do
    workout = FactoryGirl.create(:workout)
    assert workout.valid?
    workout.what = "not in types"
    assert workout.invalid?
    assert workout.errors[:what].any?
    Workout::TYPES.each do |type|
      workout.what = type
      assert workout.valid?
    end
  end

  test "time must be after now" do
    workout = FactoryGirl.create(:workout)
    assert workout.valid?
    workout.time = DateTime.now.beginning_of_day
    assert workout.invalid?
    assert workout.errors[:time].any?
  end

  test "find by range" do
    first = (10.day.from_now(Date.today))
    last = (20.day.from_now(Date.today))
    span = (first..last)
    span.each do |date|
      FactoryGirl.create(:workout, :time => date.to_datetime)
    end

    assert_equal Workout.find_by_range(first, last).size, last-first
    first = (15.day.from_now(Date.today))
    assert_equal Workout.find_by_range(first, last).size, last-first
    first = (20.day.from_now(Date.today))
    assert_equal Workout.find_by_range(first, last).size, last-first
  end
end
