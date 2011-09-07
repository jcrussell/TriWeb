require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  setup do
    @user_one = FactoryGirl.create(:user)
    @user_two = FactoryGirl.create(:user, :email => "test2@test.com")
    @moderator = FactoryGirl.create(:user, :email => "test3@test.com")
    @moderator.add_role "moderator"
    @moderator.save
    @workout = FactoryGirl.create(:workout)
  end

  test "should get redirected to sign in" do
    get :new
    assert_requires_user
    post :create, :workout => @workout.attributes
    assert_requires_user
    get :show, :id => @workout.to_param
    assert_requires_user
    get :edit, :id => @workout.to_param
    assert_requires_user
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_requires_user
    delete :destroy, :id => @workout.to_param
    assert_requires_user
  end

  test "should get new" do
    sign_in @user_one
    get :new
    assert_response :success
  end

  test "should create workout" do
    sign_in @user_one
    assert_difference('Workout.count') do
      post :create, :workout => @workout.attributes
    end

    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should show workout" do
    sign_in @user_one
    get :show, :id => @workout.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in @user_one
    get :edit, :id => @workout.to_param
    assert_response :success
  end

  test "should update workout" do
    sign_in @user_one
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to workout_path(@workout)
  end

  test "should get edit for moderator" do
    sign_in @moderator
    get :edit, :id => @workout.to_param
    assert_response :success
  end

  test "should update workout for moderator" do
    sign_in @moderator
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to workout_path(@workout)
  end

  test "should not get edit" do
    sign_in @user_two
    get :edit, :id => @workout.to_param
    assert_redirected_to calendar_index_path
    assert_equal 'Cannot edit workout, it does not exist or you did not create it.', flash[:alert]
  end

  test "should not update workout" do
    sign_in @user_two
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to calendar_index_path
    assert_equal 'Cannot update workout, it does not exist or you did not create it.', flash[:alert]
  end

  test "should not destroy workout" do
    sign_in @user_two
    assert_no_difference('Workout.count') do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to calendar_index_path
    assert_equal 'Cannot destroy workout, it does not exist or you did not create it.', flash[:alert]
  end

  test "should destroy workout" do
    sign_in @user_one
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to workouts_path
  end

  test "should destroy workout for moderator" do
    sign_in @moderator
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to workouts_path
  end
end
