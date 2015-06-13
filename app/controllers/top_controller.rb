# coding: utf-8

# Page Top
class TopController < ApplicationController
  LIMIT_ROWS = 10 # プロジェクト表示件数

  def index
    @projects = Project.last(LIMIT_ROWS).reverse
  end

  def help
  end

  def feed
    @projects = Project.last(LIMIT_ROWS).reverse
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
