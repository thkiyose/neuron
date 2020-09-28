require "rails_helper"
RSpec.describe User, type: :model do
  it "is valid with user_name,email,password,password_confirmation" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end
  it "is invalid without user_name" do
    user = FactoryBot.create(:user, user_name: nil)
    user.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:user_name]).to include("を入力してください")
  end
  it "is invalid without email" do
    user = FactoryBot.create(:user, email: nil)
    user.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:email]).to include("を入力してください")
  end
  it "is invalid without password" do
    user = FactoryBot.create(:user, password: nil)
    user.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:password]).to include("を入力してください")
  end
  it "is invalid without password_confirmation even password itself was inputted" do
    user = FactoryBot.create(:user, password_confirmation: "different")
    user.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
  it "is valid with user_name has no more characters than 20" do
    user = FactoryBot.create(:user, user_name: "#{ "a" * 20 }")
    expect(user).to be_valid
  end
  it "is invalid with user_name has more characters than 20" do
    user = FactoryBot.create(:user, user_name: "#{ "a" * 21 }")
    user.valid?
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:user_name]).to include("は20文字以内で入力してください")
  end
  it "is invalid with non-unique email" do
    user = FactoryBot.create(:user, email: "user@email.com")
    another_user = User.create(user_name: "user2",
                               email: "user@email.com",
                               password: "password",
                               password_confirmation: "password")
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end
  it "is valid with password has more characters than 6" do
    user = FactoryBot.create(:user, password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user).to be_valid
  end
  it "is invalid with password has 5 characters or less" do
    user = FactoryBot.create(:user, password: "12345", password_confirmation: "12345")
    rescue ActiveRecord::RecordInvalid => e
    expect(e.record.errors[:password]).to include("は6文字以上で入力してください")
  end
end
