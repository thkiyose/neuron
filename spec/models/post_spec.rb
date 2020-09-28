require "rails_helper"
RSpec.describe Post, type: :model do
  it "is invalid without content" do
    contribution = FactoryBot.create(:contribution)
    post = contribution.build_post(content: nil)
    post.valid?
    expect(post.errors[:content]).to include("を入力してください")
  end
  it "is valid with content has no more characters than 500" do
    contribution = FactoryBot.create(:contribution)
    post = contribution.build_post(content: "#{ "a" * 500 }")
    expect(post).to be_valid
  end
  it "is invalid with content has more characters than 500" do
    contribution = FactoryBot.create(:contribution)
    post = contribution.build_post(content: "#{ "a" * 501 }")
    post.valid?
    expect(post.errors[:content]).to include("は500文字以内で入力してください")
  end
end
