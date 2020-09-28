require "rails_helper"
RSpec.describe Option, type: :model do
  it "is invalid without option_name" do
    que = FactoryBot.create(:que)
    option = que.options.build(option_name: nil)
    option.valid?
    expect(option.errors[:option_name]).to include("を入力してください")
  end
  it "is valid with option_name has no more characters than 30" do
    que = FactoryBot.create(:que)
    option = que.options.build(option_name: "#{"a"* 30}")
    expect(option).to be_valid
  end
  it "is invalid with option_name has more characters than 30" do
    que = FactoryBot.create(:que)
    option = que.options.build(option_name: "#{"a"* 31}")
    option.valid?
    expect(option.errors[:option_name]).to include("は30文字以内で入力してください")
  end
end
