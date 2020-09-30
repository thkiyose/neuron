require "rails_helper"

RSpec.describe "Profiles", type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1,screen_name: "ログインテストユーザー1",introduction: "テスト用のプロフィール1です").save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(id: 2,screen_name: "ログインテストユーザー2",introduction: "テスト用のプロフィール2です").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
  end
  describe "user profile pages" do
    context "when user is logging in" do
      it "should be profile information of the user shown in profile page" do
        visit profile_path(1)
        expect(page).to have_content 'ログインテストユーザー1'
        expect(page).to have_content 'テスト用のプロフィール1です'
      end
      it "should be profile information of the other user shown in profile page" do
        visit profile_path(2)
        expect(page).to have_content 'ログインテストユーザー2'
        expect(page).to have_content 'テスト用のプロフィール2です'
      end
    end
  end
  describe "user profile edit" do
    context "when user is logging in" do
      it "can edit profile information of the current user and update" do
        visit profile_path(1)
        click_link I18n.t("activerecord.views.edit")
        expect(current_path).to eq edit_profile_path(1)
        fill_in 'profile[screen_name]', with: '編集済みユーザー'
        fill_in 'profile[introduction]', with: 'ユーザープロフィール情報を編集しました'
        click_button "プロフィール更新"
        expect(current_path).to eq profile_path(1)
        expect(page).to have_content '編集済みユーザー'
        expect(page).to have_content 'ユーザープロフィール情報を編集しました'
      end
      it "cannot edit the profile information of the other user" do
        visit profile_path(2)
        expect(page).not_to have_content I18n.t("activerecord.views.edit")
        visit edit_profile_path(2)
        expect(current_path).not_to eq edit_profile_path(2)
      end
    end
  end
end
