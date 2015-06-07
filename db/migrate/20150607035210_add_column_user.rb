class AddColumnUser < ActiveRecord::Migration
  def change
      add_column :users, :image, :string
  end
end
