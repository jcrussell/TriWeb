ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  def assert_requires_user
    assert_redirected_to new_user_session_path
    assert_equal 'You need to sign in or sign up before continuing.', flash[:alert]
  end

  def assert_requires_role
    assert_redirected_to root_path
    assert_equal 'Sorry, insufficient privileges.', flash[:alert]
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
