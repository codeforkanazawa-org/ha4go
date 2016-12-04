require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:user_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { description: @user.description, email: @user.email, name: @user.name }, skill_names: { skill_ids: [] }, new_skills: { new_skills: '' }
    assert_redirected_to user_path(assigns(:user))
  end
end
