require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user2)
  end
  describe 'User registrations and sessions' do
    context 'when user is not logging in' do
      it 'can create a new user and log in' do
        visit tasks_path
        click_link 'SignUp'
        sleep 0.5
        fill_in 'user[name]', with: 'test_user'
        fill_in 'user[email]', with: 'test_user@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'test_user'
        expect(page).to have_content 'test_user@test.com'
      end
      it 'can log in' do
        visit tasks_path
        click_link 'LogIn'
        sleep 0.5
        fill_in 'Email', with: 'test_user1@test.com'
        fill_in 'Password', with: 'password1'
        click_button 'Log in'
        expect(page).to have_content 'テストユーザー1'
        expect(page).to have_content 'test_user1@test.com'
      end
    end
    context '一般ユーザーでログインしている場合' do
      before do
        visit tasks_path
        click_link 'LogIn'
        sleep 0.5
        fill_in 'Email', with: 'test_user1@test.com'
        fill_in 'Password', with: 'password1'
        click_button 'Log in'
      end
      it '自分の詳細が画面に表示されている(show)' do
        expect(page).to have_content 'テストユーザー1'
        expect(page).to have_content 'test_user1@test.com'
      end
      it 'ログアウトが出来る' do
        click_link 'LogOut'
        expect(page).to have_content 'ログインして下さい'
      end
    end
  end
end
