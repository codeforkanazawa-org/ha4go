class AddImageToProjectUpdate < ActiveRecord::Migration[4.2]
  def change
    add_column :project_updates, :comment_image, :string
  end
end
