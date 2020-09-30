require "rails_helper"

RSpec.describe "UserRelation", type: :system do
  before do
    user1 = FactoryBot.create(:user)
    user1.build_profile(id: 1, screen_name: "テストユーザー1", introduction: "フォローテストユーザー1です").save
    user2 = FactoryBot.create(:user2)
    user2.build_profile(id: 2, screen_name: "テストユーザー2", introduction: "フォローテストユーザー2です").save
    visit new_user_session_path
    fill_in "user[email]", with: "user@email.com"
    fill_in "user[password]", with: "password"
    click_button "ログイン"
  end
  describe "user profile page" do
    context "when user didn't follow other user" do
      it "can follow other user", js: true do
        visit profile_path(2)
        click_button "フォロー"
        expect(page).to have_button("フォロー解除")
      end
      it "cannot follow current_user itself" do
        visit profile_path(1)
        expect(page).not_to have_button("フォロー")
      end
      it "should be correct that each number shown at following/follower users counters in each profile pages", js:true do
        # before user1 follows user2
        visit profile_path(1)
        expect(page).to have_content("フォローしているユーザー：0")
        visit profile_path(2)
        expect(page).to have_content("フォローされているユーザー：0")
        # user1 follows user2
        visit profile_path(2)
        click_button "フォロー"
        # counters increased
        expect(page).to have_content("フォローされているユーザー：1")
        visit profile_path(1)
        expect(page).to have_content("フォローしているユーザー：1")
      end
    end
    context "when user is following other user", js:true do
      before do
        visit profile_path(2)
        click_button "フォロー"
      end
      it "can unfollow other user" do
        visit profile_path(2)
        click_button "フォロー解除"
        expect(page).to have_button("フォロー")
      end
      it "should be correct that each number shown at following/follower users counters in each profile pages" do
        # before user1 unfollows user2
        visit profile_path(1)
        expect(page).to have_content("フォローしているユーザー：1")
        visit profile_path(2)
        expect(page).to have_content("フォローされているユーザー：1")
        # user1 unfollows user2
        visit profile_path(2)
        click_button "フォロー解除"
        # counters decreased
        expect(page).to have_content("フォローされているユーザー：0")
        visit profile_path(1)
        expect(page).to have_content("フォローしているユーザー：0")
      end
    end
  end
end
