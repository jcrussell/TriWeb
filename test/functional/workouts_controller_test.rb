require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  setup do
    @user_one = FactoryGirl.create(:user)
    @user_two = FactoryGirl.create(:user, :email => "test2@test.com")
    @workout = FactoryGirl.create(:workout)
    @request.env["HTTP_REFERER"] = "/"
  end

  test "should get redirected to sign in" do
    get :new
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
    post :create, :workout => @workout.attributes
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
    get :show, :id => @workout.to_param
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
    get :edit, :id => @workout.to_param
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
    delete :destroy, :id => @workout.to_param
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
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
    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should not get edit" do
    sign_in @user_two
    get :edit, :id => @workout.to_param
    assert_redirected_to @request.env["HTTP_REFERER"]
  end

  test "should not update workout" do
    sign_in @user_two
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to @request.env["HTTP_REFERER"]
  end

  test "should not destroy workout" do
    sign_in @user_two
    assert_difference('Workout.count', 0) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to @request.env["HTTP_REFERER"]
  end

  test "should destroy workout" do
    sign_in @user_one
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to workouts_path
  end
end
