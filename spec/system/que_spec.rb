require 'rails_helper'

RSpec.describe 'Ques', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(screen_name: "ログインテストユーザー1").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
  end
  describe 'home' do
    context 'when user is logging in' do
      it 'can create a que' do
        visit root_path
        click_link "que作成フォームに切り替え"
        fill_in 'que[question]', with: "test question"
        fill_in 'que[options_attributes][0][option_name]', with: "option1"
        fill_in 'que[options_attributes][1][option_name]', with: "option2"
        fill_in 'que[options_attributes][2][option_name]', with: "option3"
        fill_in 'que[options_attributes][3][option_name]', with: "option4"
        click_button "投稿"
        expect(page).to have_content "queを投稿しました"
        expect(page).to have_content "test question"
        expect(page).to have_content "option1"
        expect(page).to have_content "option2"
        expect(page).to have_content "option3"
        expect(page).to have_content "option4"
      end
    end
  end
end
