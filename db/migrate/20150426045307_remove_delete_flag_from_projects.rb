class RemoveDeleteFlagFromProjects < ActiveRecord::Migration[4.2]
  def change
    remove_column :projects, :delete_flag, :integer
  end
end
