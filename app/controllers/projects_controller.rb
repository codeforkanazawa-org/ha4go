# coding: utf-8
class ProjectsController < ApplicationController
  helper SnsHelper
  before_action :set_project, only: [:show, :edit, :update, :destroy, :join, :leave]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project   = Project.new
    @skills    = Skill.all
    @users     = User.all
    @my_skills = []
  end

  # GET /projects/1/edit
  def edit
    @stages = Stage.all
    @users  = User.all
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user_id = @my_user.id
    skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
    @project.update_skill_ids_by_skill_names(skills) if skills.size > 0

    if @project.save
      @project.send_mail_users.pluck(:email).compact.each do |m|
        ProjectMailer.tell_create(m, @project).deliver_now unless m == ''
      end
      redirect_to @project, notice: I18n.t('projects.banner.created')
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
      @project.update_skill_ids_by_skill_names(skills) if skills.size > 0
      redirect_to @project, notice: I18n.t('projects.banner.updated')
    else
      render :edit
    end
  end

  # GET /projects/add
  # メンバー追加
  def add
  end

  # Join Project
  def join
    if @my_user.nil?
      redirect_to @project, notice: I18n.t('projects.banner.cannot')
    else
      @project.users << @my_user
      redirect_to @project, notice: I18n.t('projects.banner.joined')
    end
  end

  # Leave Project
  def leave
    if @my_user.nil?
      redirect_to @project, notice: I18n.t('projects.banner.cannot')
    else
      begin
        @project.users.delete(@my_user)
        redirect_to @project, notice: I18n.t('projects.banner.leaved')
      rescue
        redirect_to @project, notice: I18n.t('projects.banner.cannot')
      end
    end
  end

  # POST /projects/add_member
  def add_member
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project  = Project.find(params[:id])
    @skills   = Skill.all
    @joinners = Project.find(params[:id]).users
    @my_skills = @project.skills.all.map { |k| k[:name] }
    if session[:user_id]
      @joined = !Project.find(params[:id]).users.find_by(id: session[:user_id]).nil?
    else
      @joined = false
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:user_id, :stage_id, :subject, :description, :user_url, :development_url)
  end
end
