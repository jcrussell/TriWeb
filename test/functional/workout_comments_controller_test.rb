require 'test_helper'

class WorkoutCommentsControllerTest < ActionController::TestCase
  setup do
    @user_one = FactoryGirl.create(:user)
    @workout = FactoryGirl.create(:workout)
    @workout_comment = FactoryGirl.create(:workout_comment)
  end

  test "should get redirected to sign in" do
    post :create, :workout_id => @workout.to_param, :workout_comment => @workout_comment.attributes
    assert_requires_user
  end

  test "should create workout_comment" do
    sign_in @user_one
    assert_difference('WorkoutComment.count') do
      post :create, :workout_id => @workout.to_param, :workout_comment => @workout_comment.attributes
    end

    assert_redirected_to workout_path(@workout)
    assert_equal 'Comment was saved successfully.', flash[:notice]
  end
end
