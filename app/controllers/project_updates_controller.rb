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
    @project_update.project.send_mail_users.pluck(:email).compact.each do | m |
      ProjectMailer.tell_update(m, @project_update).deliver_now
    end

    if @project_update.save
      redirect_to project_path(id: params[:project_update][:project_id]), notice: 'フォローを投稿しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /project_updates/1
  def update
    if @project_update.update(project_update_params)
      redirect_to @project_update, notice: '投稿を修正しました。'
    else
      render :edit
    end
  end

  # DELETE /project_updates/1
  def destroy
    @project_update.destroy
    redirect_to project_url, notice: 'フォローを削除しました。'
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
