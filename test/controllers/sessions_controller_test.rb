require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
