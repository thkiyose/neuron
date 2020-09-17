class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :screen_name
      t.text :introduction

      t.timestamps
    end
  end
end
