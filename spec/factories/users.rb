FactoryBot.define do

  factory :test_user_1, class: User do
    name { 'test_user_1' }
    email { 'test_user_1@example.com' }
    introduction { 'Hello!' }
    address { '東京都墨田区押上１丁目１−２' }
    password { 'test_user_1@example.com' }
  end

  factory :test_user_2, class: User do
    name { 'test_user_2' }
    email { 'test_user_2@example.com' }
    introduction { 'Hello!' }
    address { '東京都港区芝公園４丁目２−８' }
    password { 'test_user_2@example.com' }
  end
end
