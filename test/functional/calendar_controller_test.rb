require 'test_helper'

class CalendarControllerTest < ActionController::TestCase

  test "should get redirected to sign in" do
    get :index
    assert_requires_user
  end

  test "should get index" do
    sign_in FactoryGirl.create(:user)
    get :index
    assert_response :success
    assert_select ".past", 3
    assert_select ".today", 1
    assert_select ".future", 10
  end

  test "should get next week" do
    sign_in FactoryGirl.create(:user)
    get :index, {'date' => 7.days.from_now(Date.today).to_s}
    assert_response :success
    assert_select ".future", 14
  end

  test "should get last week" do
    sign_in FactoryGirl.create(:user)
    get :index, {'date' => 7.days.ago(Date.today).to_s}
    assert_response :success
    assert_select ".past", 10
    assert_select ".today", 1
    assert_select ".future", 3
  end
end
