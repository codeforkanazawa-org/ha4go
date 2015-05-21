class TopController < ApplicationController
  def index
    @projects = Project.all
  end

  def help
  end
end
