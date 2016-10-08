# coding: utf-8
class ProjectUpdatesController < ApplicationController
  before_action :set_project_update, only: [:show, :edit, :update, :destroy]

  # GET /project_updates/new
  def new
    @project_update = ProjectUpdate.new
  end

  # GET /project_updates/1/edit
  def edit
  end

  # POST /project_updates
  def create
    @project_update = ProjectUpdate.new(project_update_params)
    @project_update.user_id = @my_user.id
    @project_update.project.send_mail_users.pluck(:email).compact.each do |m|
      ProjectMailer.tell_update(m, @project_update).deliver_now unless m == ''
    end

    if @project_update.save
      redirect_to project_path(id: params[:project_update][:project_id]), notice: 'フォローを投稿しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /project_updates/1
  def update
    logger.fatal(params[:do_delete])
    unless @project_update.user_id == @my_user.id || @project_update.Project.user_id == @my_user.id
      redirect_to project_path(id: params[:project_update][:project_id]), notice: 'フォローを修正できませんでした'
    end

    if @project_update.update(project_update_params)
      history = ProjectUpdateHistory.new(
        user_id: @my_user.id,
        project_update_id: @project_update.id
      )
      history.save
      redirect_to project_path(id: params[:project_update][:project_id]), notice: 'フォローを修正しました。'
    else
      render :edit
    end
  end

  # DELETE /project_updates/1
  def destroy
    @project_update.description = "( #{@my_user.name} さんが削除しました )"
    @project_update.freezing = true
    if @project_update.save
      history = ProjectUpdateHistory.new(
        user_id:           @my_user.id,
        project_update_id: @project_update.id
      )
      history.save
    end
    redirect_to project_path(id: @project_update.project_id), notice: 'フォローを削除しました。'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project_update
    @project_update = ProjectUpdate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_update_params
    params.require(:project_update).permit(:project_id, :description)
  end
end
