class AddImagesToProject < ActiveRecord::Migration
  def change
    add_column :projects, :images, :text
  end
end
