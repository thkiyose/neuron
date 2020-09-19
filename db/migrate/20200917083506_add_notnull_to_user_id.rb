class AddNotnullToUserId < ActiveRecord::Migration[5.2]
  def change
    change_column :contributions, :user_id, :bigint, null: false
  end
end
