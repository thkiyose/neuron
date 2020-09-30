require "rails_helper"

RSpec.describe "Favorite", type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1, screen_name: "お気に入りテストユーザー", introduction: "お気に入りのテストです").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
    user1.contributions.create(id:1)
    post = Post.create(contribution_id:1, content: "post test content")
  end
  describe "home", js: true do
    context "when a contribution has not been favorited already" do
      it "can be favorited" do
        visit root_path
        click_button "お気に入り"
        expect(page).to have_button("お気に入り解除")
      end
      it "should be increased number of favorite at the counter" do
        visit root_path
        expect(page).to have_content "0人のユーザーがお気に入りしました"
        click_button "お気に入り"
        expect(page).to have_content "1人のユーザーがお気に入りしました"
      end
    end
    context "when a contribution has been favorited already" do
      before do
        visit root_path
        click_button "お気に入り"
      end
      it "can destroy favorite" do
        visit root_path
        click_button "お気に入り解除"
        expect(page).to have_button("お気に入り")
      end
      it "should be decreased number of favorite at the counter" do
        visit root_path
        expect(page).to have_content "1人のユーザーがお気に入りしました"
        click_button "お気に入り解除"
        expect(page).to have_content "0人のユーザーがお気に入りしました"
      end
    end
  end
  describe "news contributions page",js: true do
    context "when a contribution has not been favorited already" do
      it "can be favorited" do
        visit news_contributions_path
        click_button "お気に入り"
        expect(page).to have_button("お気に入り解除")
      end
      it "should be increased number of favorite at the counter" do
        visit news_contributions_path
        expect(page).to have_content "0人のユーザーがお気に入りしました"
        click_button "お気に入り"
        expect(page).to have_content "1人のユーザーがお気に入りしました"
      end
    end
    context "when a contribution has been favorited already" do
      before do
        visit news_contributions_path
        click_button "お気に入り"
      end
      it "can destroy favorite" do
        visit news_contributions_path
        click_button "お気に入り解除"
        expect(page).to have_button("お気に入り")
      end
      it "should be decreased number of favorite at the counter" do
        visit news_contributions_path
        expect(page).to have_content "1人のユーザーがお気に入りしました"
        click_button "お気に入り解除"
        expect(page).to have_content "0人のユーザーがお気に入りしました"
      end
    end
  end
  describe "user profile page",js: true do
    context "when a contribution has not been favorited already" do
      it "can be favorited" do
        visit profile_path(1)
        click_button "お気に入り"
        expect(page).to have_button("お気に入り解除")
      end
      it "should be increased number of favorite at the counter" do
        visit profile_path(1)
        expect(page).to have_content "0人のユーザーがお気に入りしました"
        click_button "お気に入り"
        expect(page).to have_content "1人のユーザーがお気に入りしました"
      end
    end
    context "when a contribution has been favorited already" do
      before do
        visit profile_path(1)
        click_button "お気に入り"
      end
      it "can destroy favorite" do
        visit profile_path(1)
        click_button "お気に入り解除"
        expect(page).to have_button("お気に入り")
      end
      it "should be decreased number of favorite at the counter" do
        visit profile_path(1)
        expect(page).to have_content "1人のユーザーがお気に入りしました"
        click_button "お気に入り解除"
        expect(page).to have_content "0人のユーザーがお気に入りしました"
      end
    end
  end
  describe "user's favorite list page", js: true do
    context "when user didn't favorite contribution at all" do
      it "should be no contributions at favorite list" do
        visit show_favorites_favorite_path(1)
        expect(page).to have_content "お気に入りした投稿はありません。"
        expect(page).not_to have_content "post test content"
      end
    end
    context "when user has favorited contribution" do
      it "should be favorited contributions at favorite list" do
        visit profile_path(1)
        click_button "お気に入り"
        visit show_favorites_favorite_path(1)
        expect(page).to have_content "post test content"
      end
    end
  end
  describe "favorited user list of contribution page", js: true do
    context "when contribution doesn't be favorited by user" do
      it "should be the favorited user in favorited user list of contribution" do
        visit show_favorited_by_favorite_path(1)
        expect("page").not_to have_content "お気に入りのテストです"
      end
    end
    context "when contribution was favorited by user" do
      it "should be the favorited user in favorited user list of contribution" do
        visit profile_path(1)
        click_button "お気に入り"
        visit show_favorited_by_favorite_path(1)
        expect(page).to have_content "お気に入りのテストです"
      end
    end
  end
end
