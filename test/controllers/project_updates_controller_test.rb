require 'test_helper'

class ProjectUpdatesControllerTest < ActionController::TestCase
  setup do
    @project_update = project_updates(:project_update_one)
    @controller.session[:user_id] = @project_update.user.id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_update" do
    assert_difference('ProjectUpdate.count') do
      post :create, params: { project_update: { description: @project_update.description, project_id: @project_update.project_id } }
    end

    assert_redirected_to project_path(@project_update.project)
  end

  test "should show project_update" do
    get :show, params: { id: @project_update }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @project_update }
    assert_response :success
  end

  test "should update project_update" do
    patch :update, params: { id: @project_update, project_update: { description: @project_update.description, project_id: @project_update.project_id } }
    assert_redirected_to project_path(@project_update.project)
  end

  test "should destroy project_update" do
    assert_no_difference('ProjectUpdate.count') do
      delete :destroy, params: { id: @project_update }
    end

    assert_redirected_to project_path(@project_update.project)
  end
end
