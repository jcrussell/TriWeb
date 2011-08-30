require 'test_helper'

class CalendarControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select ".past", 3
    assert_select ".today", 1
    assert_select ".future", 10
  end
end
