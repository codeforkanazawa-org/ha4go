class AddLastCommentedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :last_commented_at, :datetime
  end
end
