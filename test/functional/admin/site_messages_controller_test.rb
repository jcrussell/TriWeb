require 'test_helper'

class Admin::SiteMessagesControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    # Admin has all roles
    @admin = FactoryGirl.create(:user, :email => "test2@test.com", :roles_mask => 2**User::ROLES_MASK.size-1)
    @site_message = FactoryGirl.create(:site_message)
  end

  test "should get redirected to sign in" do
    get :new
    assert_requires_user
    post :create, :site_message => @site_message.attributes
    assert_requires_user
    get :edit, :id => @site_message.to_param
    assert_requires_user
    put :update, :id => @site_message.to_param, :site_message => @site_message.attributes
    assert_requires_user
    delete :destroy, :id => @site_message.to_param
    assert_requires_user
  end

  test "should get permission denied" do
    sign_in @user
    get :new
    assert_requires_role
    post :create, :site_message => @site_message.attributes
    assert_requires_role
    get :edit, :id => @site_message.to_param
    assert_requires_role
    put :update, :id => @site_message.to_param, :site_message => @site_message.attributes
    assert_requires_role
    delete :destroy, :id => @site_message.to_param
    assert_requires_role
  end

  test "should get new" do
    sign_in @admin
    get :new
    assert_response :success
  end

  test "should create message" do
    sign_in @admin
    assert_difference('SiteMessage.count') do
      post :create, :site_message => @site_message.attributes
    end

    assert_redirected_to root_path
  end

  test "should get edit" do
    sign_in @admin
    get :edit, :id => @site_message.to_param
    assert_response :success
  end

  test "should update message" do
    sign_in @admin
    put :update, :id => @site_message.to_param, :site_message => @site_message.attributes
    assert_redirected_to root_path
  end

  test "should destroy message" do
    sign_in @admin
    assert_difference('SiteMessage.count', -1) do
      delete :destroy, :id => @site_message.to_param
    end

    assert_redirected_to root_path
  end
end
