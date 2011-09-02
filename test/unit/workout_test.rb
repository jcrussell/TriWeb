require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase

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
end
