class RemoveDeleteFlagFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :delete_flag, :integer
  end
end
