class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
      t.references :que, foreign_key: true, null:false
      t.string :option_name, null:false, limit: 30

      t.timestamps
    end
  end
end
