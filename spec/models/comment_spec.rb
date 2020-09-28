require "rails_helper"
RSpec.describe Comment, type: :model do
  it "is invalid without a content" do
    comment = Comment.new(content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("を入力してください")
  end
  it "is valid with a content has no more characters than 500" do
    contribution = FactoryBot.create(:contribution)
    comment = Comment.new(user_id: User.last.id,contribution_id:contribution.id,content: "#{"a"*500}")
    expect(comment).to be_valid
  end
  it "is invalid with a content has more characters than 500" do
    comment = Comment.new(content: "#{"a"*501}")
    comment.valid?
    expect(comment.errors[:content]).to include("は500文字以内で入力してください")
  end
end
