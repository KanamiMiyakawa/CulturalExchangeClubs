require "csv"
# CSV.foreach('db/csv/iso693-1-language-codes-ja-sorted.csv', headers: true) do |row|
#   Language.create(
#     code: row['code'],
#     en_name: row['en_name'],
#     ja_name: row['ja_name']
#   )
# end
#
CSV.foreach('db/csv/seed_data_user.csv', headers: true) do |row|
  User.create!(
    name: row['name'],
    email: row['name'],
    password: row['name'],
    address: row['address'],
    introduction: "Hello! This is default introduction"
  )
end

# User.create!(
#   name: "user_x@example.com",
#   email: "user_x@example.com",
#   introduction: "Hello!",
#   password: "user_x@example.com",
#   address: "東京都	江戸川区	小松川	3-7"
# )
