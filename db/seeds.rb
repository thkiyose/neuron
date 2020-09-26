content_sample = ["テストをする","シードデータを作る","Railsを楽しむ"]
question_sample = ["テスト結果は良好ですか？","正しく動いていますか？","seedデータが存在していますか？"]

user1 = User.create(user_name:"利用者1",email:"test1@test.com",password:"password",password_confirmation:"password",admin:false)
user2 = User.create(user_name:"利用者2",email:"test2@test.com",password:"password",password_confirmation:"password",admin:false)
user3 = User.create(user_name:"利用者3",email:"test3@test.com",password:"password",password_confirmation:"password",admin:false)
user4 = User.create(user_name:"管理者1",email:"test4@test.com",password:"password",password_confirmation:"password",admin:true)
users = [user1,user2,user3,user4]
n = 0

users.each do |user|
  n += 1
  user.create_profile(screen_name:"テストユーザー#{n}",introduction:"テスト用のユーザーデータです")
end

20.times do |n|
  users.each do |user|
    contribution = user.contributions.create
    contribution.create_post(content:"#{content_sample.sample}#{n}")
  end
end

5.times do |n|
  users.each do |user|
    contribution = user.contributions.create
    que = contribution.create_que(question:"#{question_sample.sample}", que_type: 0)
    4.times do |n|
      que.options.create(option_name: "回答#{n}")
    end
  end
end
