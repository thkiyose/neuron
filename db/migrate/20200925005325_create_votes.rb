class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :option, foreign_key: true, null:false
      t.references :user, foreign_key: true, null:false

      t.timestamps
    end
    add_index :votes, [:option_id, :user_id], unique: true
  end
end
