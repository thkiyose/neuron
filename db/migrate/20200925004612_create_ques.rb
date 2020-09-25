class CreateQues < ActiveRecord::Migration[5.2]
  def change
    create_table :ques do |t|
      t.references :contribution, foreign_key: true, null:false
      t.text :question, null:false
      t.integer :que_type, null:false

      t.timestamps
    end
  end
end
