require "csv"
CSV.foreach('db/csv/iso693-1-language-codes-ja-sorted.csv', headers: true) do |row|
  Language.create(
    code: row['code'],
    en_name: row['en_name'],
    ja_name: row['ja_name']
  )
end

CSV.foreach('db/csv/seed_data_user.csv', headers: true) do |row|
  User.create!(
    name: row['name'],
    email: row['name'],
    password: row['name'],
    address: row['address'],
    introduction: "Hello! This is default introduction"
  )
end

# user1~5はそれぞれgroup1~5のオーナー
5.times do |n|
  n += 1
  if n%2 == 0
    permission = true
  else
    permission = false
  end
  Group.create!(
    owner_id: n,
    name: "group_#{n}",
    detail: "Hello! This is default introduction",
    permission: permission
  )
end

# user6~10はそれぞれ２グループのオーガナイザーを兼ねる
member = 0
5.times do |n|
  2.times do |m|
    member += 1
    
    g = n + m + 1
    g = 1 if n + m + 1 > 5

    Member.create!(
      user_id: n + 6,
      group_id: g,
    )

    Organizer.create!(
      user_id: n + 6,
      group_id: g,
    )

  end
end

#
# 50.times do |n|
#   name = Faker::Games::Pokemon.name
#   email = Faker::Internet.email
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                )
# end
