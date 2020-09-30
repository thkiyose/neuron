require "rails_helper"

RSpec.describe "Comments", type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1).save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(id: 2).save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    user1.contributions.create(id:1)
    post1 = Post.create(contribution_id:1, content: "post1 test content")
  end
  describe "home" do
    context "when user is logging in", js: true do
      it "can create a comment on a contribution" do
        visit root_path
        find(".comments_open").click
        fill_in 'comment[content]', with: 'テストコメント'
        click_button "コメント"
        expect(page).to have_content "テストコメント"
      end
      it "cannot create a comment with invalid content" do
        visit root_path
        find(".comments_open").click
        fill_in 'comment[content]', with: ""
        click_button "コメント"
        expect(page).to have_content "コメント内容を入力してください"
      end
    end
  end
  describe "new contributions page", js: true do
    context "when user is logging in" do
      it "can create a comment on a contribution" do
        visit news_contributions_path
        find(".comments_open").click
        fill_in 'comment[content]', with: 'テストコメント'
        click_button "コメント"
        expect(page).to have_content "テストコメント"
      end
      it "cannot create a comment with invalid content" do
        visit news_contributions_path
        find(".comments_open").click
        fill_in 'comment[content]', with: ""
        click_button "コメント"
        expect(page).to have_content "コメント内容を入力してください"
      end
    end
    context "when user is not logging in" do
      it "cannot create a comment on a contribution" do
        visit news_contributions_path
        click_link "ログアウト"
        visit news_contributions_path
        find(".comments_open").click
        expect(page).not_to have_selector "#comment_form"
      end
    end
  end
  describe "user profile page", js: true do
    context "when user is logging in" do
      it "can create a comment on a contribution" do
        visit profile_path(1)
        find(".comments_open").click
        fill_in 'comment[content]', with: 'テストコメント'
        click_button "コメント"
        expect(page).to have_content "テストコメント"
      end
      it "cannot create a comment with invalid content" do
        visit profile_path(1)
        find(".comments_open").click
        fill_in 'comment[content]', with: ""
        click_button "コメント"
        expect(page).to have_content "コメント内容を入力してください"
      end
    end
  end
end
