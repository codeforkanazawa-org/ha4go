class ChangeColumnToProject < ActiveRecord::Migration[4.2]
  def change
      change_column :projects, :stage_id, :integer, null: false, default: 1
  end
end
