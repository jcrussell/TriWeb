require 'test_helper'

class WorkoutAttendeesControllerTest < ActionController::TestCase
  setup do
    @user_one = FactoryGirl.create(:user)
    @user_two = FactoryGirl.create(:user, :email => "test2@test.com")
    @workout = FactoryGirl.create(:workout)
    @workout_two = FactoryGirl.create(:workout)
    @workout_attendee = FactoryGirl.create(:workout_attendee)
  end

  test "should get redirected to sign in" do
    post :create, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    assert_requires_user
    put :update, :id => @workout_attendee.to_param, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    assert_requires_user
  end

  test "should create workout_attendee" do
    sign_in @user_one
    @workout_attendee.workout = @workout_two
    assert_difference('WorkoutAttendee.count') do
      post :create, :workout_id => @workout_two.to_param, :workout_attendee => @workout_attendee.attributes
    end

    assert_redirected_to workout_path(@workout_two)
    assert_equal 'Workout attendance was saved successfully.', flash[:notice]
  end

  test "should not create duplicate workout_attendee" do
    sign_in @user_one
    assert_no_difference('WorkoutAttendee.count') do
      post :create, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    end

    assert_redirected_to workout_path(@workout)
    assert_equal 'Failed to save workout attendance.', flash[:alert]
  end

  test "should update workout_attendee" do
    sign_in @user_one
    put :update, :id => @workout_attendee.to_param, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    assert_redirected_to workout_path(@workout)
    assert_equal 'Workout attendance was updated successfully.', flash[:notice]
  end

  test "should not update workout_attendee wrong user" do
    sign_in @user_two
    put :update, :id => @workout_attendee.to_param, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    assert_redirected_to workout_path(@workout)
    assert flash[:alert].blank?
    assert flash[:notice].blank?
  end

  test "should delete workout_attendee" do
    sign_in @user_one
    @workout_attendee.likelihood = 0
    assert_difference('WorkoutAttendee.count', -1) do
      put :update, :id => @workout_attendee.to_param, :workout_id => @workout.to_param, :workout_attendee => @workout_attendee.attributes
    end
    assert_redirected_to workout_path(@workout)
    assert_equal 'Workout attendance was removed successfully.', flash[:notice]
  end
end
