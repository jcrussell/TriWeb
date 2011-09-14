require 'test_helper'

class SiteMessageHelperTest < ActionView::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:site_message)
    FactoryGirl.create(:site_message, :internal => 1)
  end

  # Signs in user and sets up proper stubs
  def sign_in_user(user)
    sign_in user
    SiteMessageHelperTest.any_instance.stubs(:user_signed_in?).returns(true)
    SiteMessageHelperTest.any_instance.stubs(:current_user).returns(user)
  end

  # Sets up proper stubs for no user signed in
  def no_sign_in_user
    SiteMessageHelperTest.any_instance.stubs(:user_signed_in?).returns(false)
    SiteMessageHelperTest.any_instance.stubs(:current_user).returns(nil)
  end

  test "should have internal messages" do
    sign_in_user @user
    render_messages
    assert_select "div", 2
  end

  test "should not have internal messages" do
    no_sign_in_user
    render_messages
    assert_select "div", 1
  end
end
