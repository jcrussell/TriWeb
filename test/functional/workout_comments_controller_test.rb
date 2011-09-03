require 'test_helper'

class WorkoutCommentsControllerTest < ActionController::TestCase
  setup do
    @user_one = FactoryGirl.create(:user)
    @workout = FactoryGirl.create(:workout)
    @workout_comment = FactoryGirl.create(:workout_comment)
  end

  test "should get redirected to sign in" do
    post :create, :workout_id => @workout.to_param, :workout_comment => @workout_comment.attributes
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
  end

  test "should create workout_comment" do
    sign_in @user_one
    assert_difference('WorkoutComment.count') do
      post :create, :workout_id => @workout.to_param, :workout_comment => @workout_comment.attributes
    end

    assert_redirected_to workout_path(@workout)
  end
end
