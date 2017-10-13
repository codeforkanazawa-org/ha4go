require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:project_one)
    @controller.session[:user_id] = @project.user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, params: { project: { description: @project.description, development_url: @project.development_url, stage_id: @project.stage_id, subject: @project.subject, user_id: @project.user_id, user_url: @project.user_url }, skill_names: { skill_ids: [] }, new_skills: { new_skills: '' } }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should show project" do
    get :show, params: { id: @project }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @project }
    assert_response :success
  end

  test "should update project" do
    patch :update, params: { id: @project, project: { description: @project.description, development_url: @project.development_url, stage_id: @project.stage_id, subject: @project.subject, user_id: @project.user_id, user_url: @project.user_url }, skill_names: { skill_ids: [] }, new_skills: { new_skills: '' } }
    assert_redirected_to project_path(assigns(:project))
  end
end
