require "csv"
CSV.foreach('db/csv/iso693-1-language-codes-ja-sorted.csv', headers: true) do |row|
  Language.create(
    code: row['code'],
    en_name: row['en_name'],
    ja_name: row['ja_name']
  )
end
