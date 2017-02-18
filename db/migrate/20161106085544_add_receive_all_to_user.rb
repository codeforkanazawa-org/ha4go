class AddReceiveAllToUser < ActiveRecord::Migration
  def change
    add_column :users, :receive_all, :bool
  end
end
