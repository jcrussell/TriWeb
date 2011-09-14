require 'test_helper'

class NavigationHelperTest < ActionView::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    # (Super) Admin has all roles
    @admin = FactoryGirl.create(:user, :email => "test2@test.com", :roles_mask => 2**User::ROLES_MASK.size-1)
  end

  # Signs in user and sets up proper stubs
  def sign_in_user(user)
    sign_in user
    NavigationHelperTest.any_instance.stubs(:user_signed_in?).returns(true)
    NavigationHelperTest.any_instance.stubs(:current_user).returns(user)
  end

  # Sets up proper stubs for no user signed in
  def no_sign_in_user
    NavigationHelperTest.any_instance.stubs(:user_signed_in?).returns(false)
    NavigationHelperTest.any_instance.stubs(:current_user).returns(nil)
  end

  test "should have admin links" do
    sign_in_user @admin
    nav = create_navigation
    assert_nil nav["login"]
    assert nav["tools"].include?(page_link("/admin/roles", :index, "manage user roles"))
    assert nav["tools"].include?(page_link("/admin/site_messages", :new, "create site message"))
  end

  test "should have not admin links" do
    sign_in_user @user
    nav = create_navigation
    assert_nil nav["login"]
    assert !nav["tools"].include?(page_link("/admin/roles", :index, "manage user roles"))
    assert !nav["tools"].include?(page_link("/admin/site_messages", :new, "create site message"))
  end

  test "should have login link" do
    no_sign_in_user
    nav = create_navigation
    assert nav["login"]
    assert_nil nav["tools"]
  end

end
