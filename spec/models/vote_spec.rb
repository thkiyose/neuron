require "rails_helper"
RSpec.describe Vote, type: :model do
  it "doesn't allow a single user to vote for the same option again" do
    user = FactoryBot.create(:user, email: "test@email.com")
    option = FactoryBot.create(:option)
    vote1 = user.votes.create(option_id: option.id)
    vote2 = user.votes.build(option_id: option.id)
    vote2.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:option_id]).to include("すでに存在します")
  end
end
