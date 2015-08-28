# coding: utf-8
class ProjectsController < ApplicationController
  helper SnsHelper
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @skills  = Skill.all
    @users   = User.all
  end

  # GET /projects/1/edit
  def edit
    @stages = Stage.all
    @users   = User.all
  end

  # POST /projects
  def create
      @project = Project.new(project_params)
      @project.user_id = @my_user.id
      @project.update_skill_ids_by_skill_names(params[:skill_names]) unless params[:skill_names].nil?

      @project.send_mail_users.each do |user|
        ProjectMailer.tell_create(user, @project).deliver
      end

      if @project.save
          redirect_to @project, notice: '課題を作成しました。'
      else
          render :new
      end
  end

  # PATCH/PUT /projects/1
  def update
      if @project.update(project_params)
          @project.update_skill_ids_by_skill_names(params[:skill_names])
          redirect_to @project, notice: '課題の内容を変更しました。'
      else
          render :edit
      end
  end

  # GET /projects/add
  # メンバー追加
  def add
  end

  # POST /projects/add_member
  def add_member
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      @skills = Skill.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:user_id, :stage_id, :subject, :description, :user_url, :development_url)
    end
end
