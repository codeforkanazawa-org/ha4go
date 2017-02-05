# coding: utf-8
class ProjectsController < ApplicationController
  include SnsPublisher
  before_action :set_project, only: [:show, :edit, :update, :destroy, :join, :leave]

  # GET /projects
  def index
    type = params[:type]
    if type == 'recent'
      @list_type = I18n.t('dic.project_recent')
      @projects = Project.recent(default_duration)
    elsif type == 'hotrank'
      @list_type = I18n.t('dic.project_hot')
      @projects = Project.hot_rank(default_duration)
    elsif type == 'match'
      @projects = []
      unless @my_user.nil?
        @list_type = I18n.t('dic.project_match_mine')
        @projects = Project.match_mine(@my_user.skills)
      end
    else
      @list_type = I18n.t('dic.project_all')
      @projects = Project.all
    end
  end

  # GET /projects/1
  def show
    @use_custom_ogp = true
    @project_rss_url = request.fullpath + '.rss'
    add_rss_urls(@project.subject, @project_rss_url)
    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  # GET /projects/new
  def new
    @project   = Project.new
    @skills    = Skill.all
    @users     = User.all
    @my_skills = []
    @parent_project = nil
    @parent_project = Project.find(params[:parent_id]) unless params[:parent_id].nil?
    @from = params[:from]
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
    @project.last_commented_at = Time.now
    skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
    @project.update_skill_ids_by_skill_names(skills) unless skills.empty?

    # 作成時自分を参加させる
    @project.users.push(@my_user)

    if @project.save
      # mail to created
      @project.send_mail_addresses.each do |m|
        ProjectMailer.tell_create(m, @project).deliver_now unless m == ''
      end

      project_publish_to_sns_page(
        "#{@my_user.name} さんが課題 #{@project.subject} を作成しました。",
        @project
      )

      # mail to skill matched
      User.joins(:skills).where(skills: { id: @project.skills }).pluck(:email).compact.each do |m|
        ProjectMailer.tell_skill_match(m, @project, true).deliver_now unless m == ''
      end

      redirect_target = params[:from].nil? ? @project : '/dashboard'
      redirect_to redirect_target, notice: I18n.t('projects.banner.created')
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    param_cache = project_params
    unless param_cache[:images].nil?
      images = @project.images
      images += param_cache[:images]
      param_cache[:images] = images
    end
    before_skills = @project.skills.map(&:id)
    if @project.update(param_cache)

      if params[:project][:remove_images].to_i > 0
        remain_images = @project.images
        remain_images.each_with_index do |_v, i|
          _deleted_image = remain_images.delete_at(i)
          # _deleted_image.try(:remove!)
        end
        @project.images = remain_images
        @project.update!(images: remain_images)
      end

      skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
      @project.update_skill_ids_by_skill_names(skills) unless skills.empty?

      current_skills = @project.skills.map(&:id)
      fue = current_skills - before_skills

      project_publish_to_sns_page(
        "#{@my_user.name} さんが課題 #{@project.subject} を更新しました。",
        @project
      )

      # mail to skill matched
      User.joins(:skills).where(skills: { id: fue }).pluck(:email).compact.each do |m|
        ProjectMailer.tell_skill_match(m, @project).deliver_now unless m == ''
      end

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
        ProjectUpdate.new(
          project_id:  @project.id,
          description: "#{@my_user.name} さんは課題 #{@project.subject} への参加を辞めました。",
          freezing:    true,
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
    params.require(:project).permit(:user_id, :stage_id, :subject, :description, :user_url, :development_url, :project_id, { images: [] }, :remove_images)
  end
end
