require 'test_helper'

class CalendarControllerTest < ActionController::TestCase

  test "should get redirected to sign in" do
    get :index
    assert_redirected_to :controller => "/devise/sessions", :action => "new"
  end

  test "should get index" do
    sign_in FactoryGirl.create(:user)
    get :index
    assert_response :success
    assert_select ".past", 3
    assert_select ".today", 1
    assert_select ".future", 10
  end
end
