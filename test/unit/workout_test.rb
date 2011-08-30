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

  test "what must be in @@types" do
    workout = FactoryGirl.create(:workout)
    workout.what = "not in types"
    assert workout.invalid?
    assert workout.errors[:what].any?
    workout.what = "Swim"
    assert workout.valid?
  end

  test "time must be after now" do
    workout = FactoryGirl.create(:workout)
    workout.time = DateTime.now.beginning_of_day
    assert workout.invalid?
    assert workout.errors[:time].any?
  end

end
