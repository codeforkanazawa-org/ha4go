# coding: utf-8
class DashboardController < ApplicationController
  def index
    @projects = Project.page(params[:page])
                       .per(10)
                       .order(updated_at: :desc)
  end
end
