require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(screen_name: "ログインテストユーザー1").save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(screen_name: "ログインテストユーザー2").save
  end
  describe 'user registrations and sessions' do
    context 'when user is not logging in' do
      it 'can create a new user and log in' do
        visit new_user_registration_path
        fill_in 'user[user_name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button "ユーザー登録"
        expect(current_path).to eq root_path
        expect(page).to have_selector "#current_user_screen_name", text: "ユーザー"
      end
      it 'cannot create a new user and log in when parameters are invalid or empty' do
        visit new_user_registration_path
        fill_in 'user[email]', with: 'aaaaaa'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'passwordinvalid'
        click_button "ユーザー登録"
        expect(page).to have_selector "#error_explanation"
      end
      it 'can log in with valid parameters' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'user@email.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
        expect(current_path).to eq root_path
        expect(page).to have_selector "#current_user_screen_name", text: "ログインテストユーザー1"
      end
      it 'cannot log in with invalid parameters' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'invalid@email.com'
        fill_in 'user[password]', with: 'passwordinvalid'
        click_button "ログイン"
        expect(page).to have_selector ".alert", text: "Eメールまたはパスワードが違います。"
      end
    end
    context 'when user is logging in' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: 'user@email.com'
        fill_in 'user[password]', with: 'password'
        click_button "ログイン"
      end
      it 'user_name is displayed on the home' do
        visit root_path
        expect(current_path).to eq root_path
        expect(page).to have_selector "#current_user_screen_name", text: 'ログインテストユーザー1'
      end
      it 'can log out' do
        click_link 'ログアウト'
        expect(current_path).to eq top_contributions_path
      end
    end
  end
end
