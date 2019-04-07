class AddReceiveAllToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :receive_all, :bool
  end
end
