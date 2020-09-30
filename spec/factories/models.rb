FactoryBot.define do
  factory :user, class: "User" do
    id { 1 }
    user_name { "test1" }
    email { "user@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :user2, class: "User" do
    id { 2 }
    user_name { "test2" }
    email { "user2@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :user3, class: "User" do
    id { 3 }
    user_name { "test3" }
    email { "user3@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :profile do
    association :user
  end
  factory :contribution1, class: "Contribution" do
    association :user
  end
  factory :contribution2, class: "Contribution" do
    association :user
  end
  factory :contribution3, class: "Contribution" do
    association :user
  end
  factory :post1, class: "Post" do
    association :contribution1
    content { "test content1" }
  end
  factory :post2, class: "Post" do
    association :contribution2
    content { "test content2" }
  end
  factory :post3, class: "Post" do
    association :contribution3
    content { "test content3" }
  end
  factory :que1, class:"Que" do
    association :contribution
    question { "is this test successful?1" }
    que_type { 0 }
  end
  factory :que2, class:"Que" do
    association :contribution
    question { "is this test successful?2" }
    que_type { 0 }
  end
  factory :que3, class:"Que" do
    association :contribution
    question { "is this test successful?3" }
    que_type { 0 }
  end
  factory :option do
    association :que
    option_name { "option" }
  end
  factory :vote do
    association :user
    association :option
  end
end
