class RemoveDeleteFlagFromProjectUpdates < ActiveRecord::Migration[4.2]
  def change
    remove_column :project_updates, :delete_flag, :integer
  end
end
