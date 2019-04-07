class AddLastCommentedAtToProject < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :last_commented_at, :datetime
  end
end
