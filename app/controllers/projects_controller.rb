# coding: utf-8
class ProjectsController < ApplicationController
  helper SnsHelper
  before_action :set_project, only: [:show, :edit, :update, :destroy, :join, :leave]

  # GET /projects
  def index
    type = params[:type]
    if type == 'recent'
      @projects = Project.recent(default_duration)
    elsif type == 'hotrank'
      @projects = Project.hot_rank(default_duration)
    elsif type == 'recruiting'
      @projects = Project.recruiting
    else
      @projects = Project.all
    end

  end

  # GET /projects/1
  def show
    @use_custom_ogp = true
    add_rss_urls(@project.subject, request.fullpath + '.rss')
    respond_to do |format|
      format.any
      format.rss { render layout: false }
    end
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
    @project.update_skill_ids_by_skill_names(skills) unless skills.empty?

    if @project.save

      # mail to created
      @project.send_mail_users.pluck(:email).compact.each do |m|
        ProjectMailer.tell_create(m, @project).deliver_now unless m == ''
      end

      # mail to skill matched
      User.joins(:skills).where(skills: { id: @project.skills }).pluck(:email).compact.each do |m|
        ProjectMailer.tell_skill_match(m, @project, true).deliver_now unless m == ''
      end

      redirect_to @project, notice: I18n.t('projects.banner.created')
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    before_skills = @project.skills.map(&:id)
    if @project.update(project_params)
      skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
      @project.update_skill_ids_by_skill_names(skills) unless skills.empty?

      current_skills = @project.skills.map(&:id)
      fue = current_skills - before_skills

      # mail to skill matched
      User.joins(:skills).where(skills: { id: fue }).pluck(:email).compact.each do |m|
        ProjectMailer.tell_skill_match(m, @project).deliver_now unless m == ''
      end

      redirect_to @project, notice: I18n.t('projects.banner.updated') + fue.to_s
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
        ProjectUpdate.new(
          project_id:  @project.id,
          description: "#{@my_user.name} さんは課題 #{@project.subject} への参加を辞めました。",
          user_id:     @my_user.id
        ).save

        @project.users.delete(@my_user)
        redirect_to @project, notice: I18n.t('projects.banner.leaved')
      rescue => e
        logger.debug(e.to_s)
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
    @use_custom_ogp = false
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:user_id, :stage_id, :subject, :description, :user_url, :development_url)
  end
end
