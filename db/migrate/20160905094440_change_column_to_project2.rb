# coding: utf-8
class ChangeColumnToProject2 < ActiveRecord::Migration[4.2]
  def up
    change_column :projects, :stage_id, :integer, default: 10
  end

  def down
    change_column :projects, :stage_id, :integer, default: 1
  end
end
