# coding: utf-8

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @skills = Skill.all
    skills = Skill.all.map { |skill| [skill.name, skill.id] }
    @options = skills.unshift(['指定なし', nil])

    if params[:skill_id].present?
      @users = User.joins(:skills).where(skills: { id: params[:skill_id] })
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      skills = Array(params[:skill_names][:skill_ids]) + params[:new_skills][:new_skills].split(' ')
      @user.update_skill_ids_by_skill_names(skills) if skills.size > 0
      redirect_to @user, notice: 'プロフィールを更新しました。'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @skills = Skill.all
    @my_skills = @user.skills.all.map { |k| k[:name] }
    @my_comments = ProjectUpdate.where(user_id: @user.id, freezing: [0, nil]).order(created_at: :desc).limit(10)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :description, :facebook_user_id)
  end
end
