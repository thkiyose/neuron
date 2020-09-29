FactoryBot.define do
  factory :user do
    user_name { "test" }
    email { "user@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :user2 do
    user_name { "test2" }
    email { "user2@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
  factory :contribution do
    association :user
  end
  factory :que do
    association :contribution
    question { "is this test successful?" }
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
