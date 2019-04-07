class AddImagesToProject < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :images, :text
  end
end
