require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @controller.session['current_url'] = '/'
    @request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end
  test "should get create" do
    get :create
    assert_response :redirect
    assert_redirected_to @controller.session['current_url']
  end

  test "should get destroy" do
    get :destroy
    assert_response :redirect
    assert_redirected_to root_url
  end

end
