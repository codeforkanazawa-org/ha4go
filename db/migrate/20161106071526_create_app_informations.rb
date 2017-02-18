class CreateAppInformations < ActiveRecord::Migration
  def change
    create_table :app_informations do |t|
      t.date :release
      t.text :description

      t.timestamps null: false
    end
  end
end
