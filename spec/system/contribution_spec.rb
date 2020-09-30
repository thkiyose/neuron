require "rails_helper"

RSpec.describe "Contributions", type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1).save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(id: 2).save
    user3 = FactoryBot.create(:user3)
    user3.build_profile(id: 3).save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    # create contributions as posts
    user1.contributions.create(id:1)
    post1 = Post.create(contribution_id:1, content: "post1 test content")
    user2.contributions.create(id:2)
    post2 = Post.create(contribution_id:2, content: "post2 test content")
    user3.contributions.create(id:3)
    post3 = Post.create(contribution_id:3, content: "post3 test content")
    # create contributions as ques
    user1.contributions.create(id:4)
    que1 = Que.create(contribution_id:4, question: "que1 test question", que_type: 0)
    que1.options.create(option_name: "option")
    user2.contributions.create(id:5)
    que2 = Que.create(contribution_id:5, question: "que2 test question", que_type: 0)
    que2.options.create(option_name: "option")
    user3.contributions.create(id:6)
    que3 = Que.create(contribution_id:6, question: "que3 test question", que_type: 0)
    que3.options.create(option_name: "option")
    # user1 follows user2
    user1.follow!(user2)
  end
  describe "home" do
    context "when user is logging in" do
      it "should be the contributions of the current user and following users only shown" do
        visit root_path
        expect(page).to have_content "post1 test content"
        expect(page).to have_content "post2 test content"
        expect(page).to have_content "que1 test question"
        expect(page).to have_content "que2 test question"
        expect(page).not_to have_content "post3 test content"
        expect(page).not_to have_content "que3 test question"
      end
      it "should be the contributions ordered discending by created time" do
        visit root_path
        contributions_list= all('.post_content')
        expect(contributions_list[0]).to have_content "que2 test question"
        expect(contributions_list[1]).to have_content "que1 test question"
        expect(contributions_list[2]).to have_content "post2 test content"
        expect(contributions_list[3]).to have_content "post1 test content"
      end
      it "can destroy contribution of current_user" do
        visit root_path
        expect(page).to have_content "post1 test content"
        expect(page).to have_content "que1 test question"
        # when destroying post, it is needed to click link to edit first.
        # post1 is able to be deleted because it is contribution of current user
        first(".edit_link").click
        find_link("投稿を削除").click
        expect(current_path).to eq root_path
        expect(page).not_to have_content "post1 test content"
        # que1 is able to be deleted because it is contribution of current user
        first(".delete_link").click
        expect(current_path).to eq root_path
        expect(page).not_to have_content "que1 test question"
      end
    end
    context "when user is not logging in" do
      it "should redirect to top page" do
        click_link 'ログアウト'
        visit root_path
        expect(current_path).to eq top_contributions_path
      end
    end
  end
  describe "new contributions page" do
    it "should be all contributions shown ordered discending by created time" do
      visit news_contributions_path
      contributions_list= all('.post_content')
      expect(contributions_list[0]).to have_content "que3 test question"
      expect(contributions_list[1]).to have_content "que2 test question"
      expect(contributions_list[2]).to have_content "que1 test question"
      expect(contributions_list[3]).to have_content "post3 test content"
      expect(contributions_list[4]).to have_content "post2 test content"
      expect(contributions_list[5]).to have_content "post1 test content"
    end
    it "can be visited by user logging in and user not logging in both" do
      visit news_contributions_path
      expect(current_path).to eq news_contributions_path
      click_link 'ログアウト'
      visit news_contributions_path
      expect(current_path).to eq news_contributions_path
    end
    it "can destroy contribution of current_user" do
      visit news_contributions_path
      expect(page).to have_content "post1 test content"
      expect(page).to have_content "que1 test question"
      # when destroying post, it is needed to click link to edit first.
      # post1 is able to be deleted because it is contribution of current user
      first(".edit_link").click
      find_link("投稿を削除").click
      visit news_contributions_path
      expect(page).not_to have_content "post1 test content"
      # que1 is able to be deleted because it is contribution of current user
      first(".delete_link").click
      visit news_contributions_path
      expect(page).not_to have_content "que1 test question"
    end
  end
  describe "user profile page" do
    it "should be the contributions by the user associated to the profile shown ordered discending by created time" do
      visit profile_path(2)
      contributions_list= all('.post_content')
      # contributions by user2
      expect(contributions_list[0]).to have_content "que2 test question"
      expect(contributions_list[1]).to have_content "post2 test content"
      # contributions by other users are not shown
      expect(page).not_to have_content "que3 test question"
      expect(page).not_to have_content "que1 test question"
      expect(page).not_to have_content "post3 test content"
      expect(page).not_to have_content "post1 test content"
    end
    it "can destroy contribution of current_user" do
      visit profile_path(1)
      expect(page).to have_content "post1 test content"
      expect(page).to have_content "que1 test question"
      # when destroying post, it is needed to click link to edit first.
      # post1 is able to be deleted because it is contribution of current user
      first(".edit_link").click
      find_link("投稿を削除").click
      visit profile_path(1)
      expect(page).not_to have_content "post1 test content"
      # que1 is able to be deleted because it is contribution of current user
      first(".delete_link").click
      visit profile_path(1)
      expect(page).not_to have_content "que1 test question"
    end
    it "can be visited by user logging in and user not logging in both" do
      visit profile_path(1)
      expect(current_path).to eq profile_path(1)
      click_link 'ログアウト'
      visit profile_path(1)
      expect(current_path).to eq profile_path(1)
    end
  end
end
