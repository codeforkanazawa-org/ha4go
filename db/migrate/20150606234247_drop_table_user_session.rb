class DropTableUserSession < ActiveRecord::Migration[4.2]
  def down
      drop_table :user_sessions
  end
end
