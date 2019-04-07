class ChangeColumnToUser < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :description, :text
  end
end
