require 'rails_helper'

RSpec.describe 'Votes', type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1,screen_name: "ログインテストユーザー1").save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(screen_name: "ログインテストユーザー2").save
    user3 = FactoryBot.create(:user3)
    user3.build_profile(screen_name: "ログインテストユーザー3").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    user1.contributions.create(id:1)
    que = Que.create(id:1, contribution_id: 1,question: "test que", que_type: 0)
    option1 = Option.create(id: 1, que_id: 1, option_name: "option1")
    option2 = Option.create(id: 2, que_id: 1, option_name: "option2")
    option3 = Option.create(id: 3, que_id: 1, option_name: "option3")
  end
  describe 'home', js:true do
    context 'when user is logging in' do
      it 'can create a vote' do
        visit root_path
        click_link "option1"
        expect(page).to have_content "option1"
        expect(page).to have_content "1票"
      end
      it 'shows the voting result of the que after voting is completed' do
        FactoryBot.create(:vote, user_id: 1,option_id: 1)
        FactoryBot.create(:vote, user_id: 2,option_id: 2)
        FactoryBot.create(:vote, user_id: 3,option_id: 2)
        visit root_path
        options_list= all('.rank_option_name')
        expect(options_list[0]).to have_content "option2"
        expect(options_list[1]).to have_content "option1"
        expect(options_list[2]).to have_content "option3"
      end
    end
  end
  describe 'new contributions page', js:true do
    context 'when user is logging in' do
      it 'can create a vote' do
        visit news_contributions_path
        click_link "option1"
        expect(page).to have_content "option1"
        expect(page).to have_content "1票"
      end
      it 'shows the voting result of the que after voting is completed' do
        FactoryBot.create(:vote, user_id: 1,option_id: 1)
        FactoryBot.create(:vote, user_id: 2,option_id: 2)
        FactoryBot.create(:vote, user_id: 3,option_id: 2)
        visit news_contributions_path
        options_list= all('.rank_option_name')
        expect(options_list[0]).to have_content "option2"
        expect(options_list[1]).to have_content "option1"
        expect(options_list[2]).to have_content "option3"
      end
    end
    context 'when user is not logging in' do
      it 'cannot create a vote' do
        visit news_contributions_path
        click_link "option1"
        expect(page).not_to have_content "1票"
      end
    end
  end
  describe 'user profile page', js: true do
    context 'when user is logging in' do
      it 'can create a vote' do
        visit profile_path(1)
        click_link "option1"
        expect(page).to have_content "option1"
        expect(page).to have_content "1票"
      end
      it 'shows the voting result of the que after voting is completed' do
        FactoryBot.create(:vote, user_id: 1,option_id: 1)
        FactoryBot.create(:vote, user_id: 2,option_id: 2)
        FactoryBot.create(:vote, user_id: 3,option_id: 2)
        visit profile_path(1)
        options_list= all('.rank_option_name')
        expect(options_list[0]).to have_content "option2"
        expect(options_list[1]).to have_content "option1"
        expect(options_list[2]).to have_content "option3"
      end
    end
    context 'when user is not logging in' do
      it 'cannot create a vote' do
        click_link "ログアウト"
        visit profile_path(1)
        click_link "option1"
        expect(page).not_to have_content "1票"
      end
    end
  end
end
