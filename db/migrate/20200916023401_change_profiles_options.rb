class ChangeProfilesOptions < ActiveRecord::Migration[5.2]
  def change
    change_column :profiles, :screen_name, :string, null: false, limit: 20, default: "ユーザー"
    change_column :profiles, :introduction, :text, limit: 300
  end
end
