require 'test_helper'

class ProjectUpdatesControllerTest < ActionController::TestCase
  setup do
    @project_update = project_updates(:project_update_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_updates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_update" do
    assert_difference('ProjectUpdate.count') do
      post :create, project_update: { description: @project_update.description, project_id: @project_update.project_id }
    end

    assert_redirected_to project_update_path(assigns(:project_update))
  end

  test "should show project_update" do
    get :show, id: @project_update
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_update
    assert_response :success
  end

  test "should update project_update" do
    patch :update, id: @project_update, project_update: { description: @project_update.description, project_id: @project_update.project_id }
    assert_redirected_to project_update_path(assigns(:project_update))
  end

  test "should destroy project_update" do
    assert_difference('ProjectUpdate.count', -1) do
      delete :destroy, id: @project_update
    end

    assert_redirected_to project_updates_path
  end
end
