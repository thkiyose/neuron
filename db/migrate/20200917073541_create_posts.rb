class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :contribution, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
