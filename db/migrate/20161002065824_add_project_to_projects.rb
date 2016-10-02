class AddProjectToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :project, index: true, foreign_key: true
  end
end
