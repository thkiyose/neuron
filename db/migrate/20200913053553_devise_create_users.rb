class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name,null:false
      t.string :email,       null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.boolean :admin, null:false,default:false
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
