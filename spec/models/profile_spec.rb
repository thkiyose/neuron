require "rails_helper"
RSpec.describe Profile, type: :model do
  it "is valid with screen_name has less characters than 20" do
    user = FactoryBot.create(:user)
    profile = user.build_profile(screen_name: "#{ "a" * 20 }")
    expect(profile).to be_valid
  end
  it "is invalid with screen_name has more characters than 20" do
    user = FactoryBot.create(:user)
    profile = user.build_profile(screen_name: "#{ "a" * 21 }")
    profile.valid?
    expect(profile.errors[:screen_name]).to include("は20文字以内で入力してください")
  end
  it "is valid with introduction has no more characters than 300" do
    user = FactoryBot.create(:user)
    profile = user.build_profile(introduction: "#{ "a" * 300 }")
    expect(profile).to be_valid
  end
  it "is invalid with introduction has more characters than 300" do
    user = FactoryBot.create(:user)
    profile = user.build_profile(introduction: "#{ "a" * 301 }")
    profile.valid?
    expect(profile.errors[:introduction]).to include("は300文字以内で入力してください")
  end
end
