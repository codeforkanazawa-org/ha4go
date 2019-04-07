class RemoveDeleteFlagFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :delete_flag, :integer
  end
end
