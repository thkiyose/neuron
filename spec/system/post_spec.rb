require 'rails_helper'
require 'support/factory_bot'

RSpec.describe 'Posts', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1,screen_name: "ログインテストユーザー1").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    visit root_path
    fill_in 'post[content]', with: "test content"
    click_button "送信"
  end
  describe 'home' do
    context 'when user is logging in' do
      it 'can create a post' do
        visit root_path
        fill_in 'post[content]', with: "投稿のテスト"
        click_button "送信"
        expect(page).to have_content "postを投稿しました"
        expect(page).to have_content "投稿のテスト"
      end
      it 'can edit a post by current user' do
        visit root_path
        expect(page).to have_content "test content"
        click_link "編集"
        fill_in 'post[content]', with: "post編集機能のテスト"
        click_button "送信"
        expect(page).to have_content "postを編集しました"
        expect(page).to have_content "post編集機能のテスト"
      end
    end
  end
  describe 'new contributions page' do
    context 'when user is logging in' do
      it 'can edit a post by current user' do
        visit news_contributions_path
        expect(page).to have_content "test content"
        click_link "編集"
        fill_in 'post[content]', with: "post編集機能のテスト"
        click_button "送信"
        expect(page).to have_content "postを編集しました"
        expect(page).to have_content "post編集機能のテスト"
      end
    end
    context 'when user is not logging in' do
      it "cannot edit a post" do
        click_link "ログアウト"
        visit news_contributions_path
        expect(page).not_to have_link "編集"
      end
    end
  end
  describe 'user profile page' do
    context 'when user is logging in' do
      it 'can edit a post by current user' do
        visit profile_path(1)
        expect(page).to have_content "test content"
        find(".post").click_link "編集"
        fill_in 'post[content]', with: "post編集機能のテスト"
        click_button "送信"
        expect(page).to have_content "postを編集しました"
        expect(page).to have_content "post編集機能のテスト"
      end
    end
  end
end
