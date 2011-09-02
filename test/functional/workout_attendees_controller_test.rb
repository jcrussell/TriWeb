require 'test_helper'

class WorkoutAttendeesControllerTest < ActionController::TestCase
  setup do
    @workout_attendee = FactoryGirl.create(:workout_attendee)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_attendees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout_attendee" do
    assert_difference('WorkoutAttendee.count') do
      post :create, :workout_attendee => @workout_attendee.attributes
    end

    assert_redirected_to workout_attendee_path(assigns(:workout_attendee))
  end

  test "should show workout_attendee" do
    get :show, :id => @workout_attendee.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @workout_attendee.to_param
    assert_response :success
  end

  test "should update workout_attendee" do
    put :update, :id => @workout_attendee.to_param, :workout_attendee => @workout_attendee.attributes
    assert_redirected_to workout_attendee_path(assigns(:workout_attendee))
  end

  test "should destroy workout_attendee" do
    assert_difference('WorkoutAttendee.count', -1) do
      delete :destroy, :id => @workout_attendee.to_param
    end

    assert_redirected_to workout_attendees_path
  end
end
