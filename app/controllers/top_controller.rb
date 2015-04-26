class TopController < ApplicationController
  def index
    @projects = Project.all
  end
end
