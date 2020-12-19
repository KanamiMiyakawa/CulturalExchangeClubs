FactoryBot.define do

  factory :test_user_1, class: User do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'test_user_1' }
    email { 'test_user_1@example.com' }
    introduction { 'Hello!' }
    address { '東京都墨田区押上１丁目１−２' }
    password { 'test_user_1@example.com' }
  end
end
