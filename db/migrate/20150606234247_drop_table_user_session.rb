class DropTableUserSession < ActiveRecord::Migration
  def down
      drop_table :user_sessions
  end
end
