class AddImageToProjectUpdate < ActiveRecord::Migration
  def change
    add_column :project_updates, :comment_image, :string
  end
end
