require "rails_helper"
RSpec.describe Que, type: :model do
  it "is invalid without question" do
    contribution = FactoryBot.create(:contribution)
    que = contribution.build_que(question: nil)
    que.valid?
    expect(que.errors[:question]).to include("を入力してください")
  end
  it "is valid with question has no more characters than 500" do
    contribution = FactoryBot.create(:contribution)
    que = contribution.build_que(question: "#{ "a" * 500 }")
    expect(que).to be_valid
  end
  it "is invalid with question has more characters than 500" do
    contribution = FactoryBot.create(:contribution)
    que = contribution.build_que(question: "#{ "a" * 501 }")
    que.valid?
    expect(que.errors[:question]).to include("は500文字以内で入力してください")
  end
end
