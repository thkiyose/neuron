require "rails_helper"
RSpec.describe UserRelation, type: :model do
  it "is valid with a user following and a user followed" do
    user1 = FactoryBot.create(:user)
    user2 = User.create( user_name: "tes2t",
                      email: "user2@email.com",
                      password: "password" ,
                      password_confirmation: "password" )
    relation1 = user1.follow!(user2)
    expect(relation1).to be_valid
  end
  it "does not allow a single user to have the id of the same user already followed as followed_id" do
    expect do
      user1 = FactoryBot.create(:user)
      user2 = User.create( user_name: "test2",
                        email: "user2@email.com",
                        password: "password" ,
                        password_confirmation: "password" )
      relation1 = user1.follow!(user2)
      relation2 = user1.follow!(user2)
    end.to raise_error( ActiveRecord::RecordNotUnique )
  end
end
