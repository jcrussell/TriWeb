require 'test_helper'

class Admin::RolesControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    # Admin has all roles
    @admin = FactoryGirl.create(:user, :email => "test2@test.com", :roles_mask => 2**User::ROLES_MASK.size-1)
  end

  test "should get redirected to sign in" do
    get :index
    assert_requires_user
    post :update
    assert_requires_user
  end

  test "should get permission denied" do
    sign_in @user
    get :index
    assert_requires_role
    post :index
    assert_requires_role
  end

  test "should get index" do
    sign_in @admin
    get :index
    assert_response :success
  end

  test "should update not remove admin role" do
    sign_in @admin
    post :update # no data => remove all roles from all users
    assert_redirected_to admin_roles_index_path
    assert_equal 'Cannot remove admin role from yourself. Will continue to update other users.', flash[:alert]
    assert_equal 'Roles were updated successfully.', flash[:notice]
  end

  test "should make user an admin" do
    sign_in @admin
    post :update, {'user' => {@user.to_param => {"admin" => "yes"}}}
    assert_redirected_to admin_roles_index_path
    assert_equal 'Roles were updated successfully.', flash[:notice]
    sign_out @admin
    sign_in @user
    get :index
    assert_response :success
  end

end
