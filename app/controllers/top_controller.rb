class TopController < ApplicationController
  LIMIT_ROWS = 10 # プロジェクト表示件数

  def index
    @projects = Project.last(LIMIT_ROWS).reverse
  end

  def help
  end
end
