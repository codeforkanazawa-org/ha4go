class ChangeColumnToProject < ActiveRecord::Migration
  def change
      change_column :projects, :stage_id, :integer, null: false, default: 1
  end
end
