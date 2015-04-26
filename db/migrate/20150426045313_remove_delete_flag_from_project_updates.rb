class RemoveDeleteFlagFromProjectUpdates < ActiveRecord::Migration
  def change
    remove_column :project_updates, :delete_flag, :integer
  end
end
