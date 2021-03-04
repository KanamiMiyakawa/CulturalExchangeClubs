namespace :whenever_test do  # ファイル名と合わせること
  desc 'テスト'
  task test: :environment do
    # ここに定期実行する処理を記述する。
    puts 'hoge'
  end
end
