require "csv"
namespace :initializing_data do
  desc "initialize database"

  # 月ごとにイベントデータを作成
  task monthly: :environment do

    # 言語は日本語と何でも、中国語、韓国語、ベトナム語、英語、ポルトガル語のいずれか
    language_ids = [1,140,148,176,177,182]

    # 当日から40日後までランダム
    def time_rand from = Time.zone.now, to = Time.zone.now + 40.days
      Time.zone.at((from + rand * (to.to_f - from.to_f)).to_i / 60 * 60)
    end

    # リアルイベント30件
    # イベント個数
    s = 0

    # 6種類を5回ずつ作成
    event_n = []
    6.times do |n|
      5.times do |m|
        event_n.push(n)
      end
    end
    event_n.shuffle!

    # イベントタイトル
    name_array = ["LanguageExchangeお茶会しよう！",
                  "お花見に行こう！",
                  "カフェでおしゃべり",
                  "フットサル大会！",
                  "BBQパーティ！",
                  "ボードゲームナイト！"
                ]

    # イベント内容
    content_array = ["LanguageExchangeはお互いの言語を学びたい人同士が集まり、おしゃべりする場です！",
                      "この近くには桜のきれいな場所がたくさんあります！\n気候もよくなってきたのでみんなで見に行きましょう！",
                      "おいしいコーヒーはお好きですか？\nお洒落なカフェでみんなでおしゃべりしましょう",
                      "運動不足のメンバーが多いと聞いてこのイベントを企画しました\n近くのフットサル場で遊びましょう！",
                      "BBQしながらみんなで美味しいお肉を食べましょう！\n材料は持ちよりなので、余っている料理や食材などがあったら是非持ってきてください",
                      "楽しくゲームをプレイしながら、お互いに交流しましょう！\n色々なおもしろいゲームがあります！"
                    ]

    # CSVから住所を取り出し、作成
    CSV.foreach("#{Rails.root}/db/csv/seed_data_address.csv", headers: true) do |row|
      name = name_array[event_n[s]]
      content = content_array[event_n[s]]

      permission = rand(2)
      if permission == 0
        permission = true
      else
        permission = false
      end

      guest = rand(2)
      if guest == 0
        guest = true
      else
        guest = false
      end

      language_ids.shuffle!
      max = rand(10..20)

      event = Event.create!(
        name: name,
        schedule: time_rand,
        organizer_id: s%5 + 1,
        group_id: s%5 + 1,
        user_id: s%5 + 1,
        content: content,
        address: row['address'],
        permission: permission,
        guest_allowed: guest,
        event_languages_attributes: [
          {
            language_id: 184,
            max: max
          },
          {
            language_id: language_ids[0],
            max: max
          }
        ]
      )

      case event_n[s]
      when 0
        event.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_conversation.mp4")), filename: "seed_conversation.mp4", content_type: 'video/mp4')
      when 1
        event.thumbnail.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_flower.jpg")), filename: "seed_flower.jpg", content_type: 'image/jpg')
      when 2
        event.thumbnail.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_coffee.jpg")), filename: "seed_coffee.jpg", content_type: 'image/jpg')
      when 4
        event.images.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_bbq.mp4")), filename: "seed_bbq.mp4", content_type: 'video/mp4')
        event.thumbnail.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_bbq_thombnail.jpg")), filename: "seed_bbq_thombnail.jpg", content_type: 'image/jpg')
      when 5
        event.thumbnail.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_game.jpg")), filename: "seed_game.jpg", content_type: 'image/jpg')
      end

      s += 1
    end

    # オンラインイベント20件
    20.times do |on_n|
      case on_n%4
      when 0
        permission = true
        guest = true
      when 1
        permission = true
        guest = false
      when 2
        permission = false
        guest = true
      when 3
        permission = false
        guest = false
      end

      language_ids.shuffle!

      max = rand(10..20)

      event = Event.create!(
        name: "オンラインお茶会！",
        schedule: time_rand,
        organizer_id: on_n%5 +1,
        group_id: on_n%5 +1,
        user_id: on_n%5 +1,
        content: "オンラインで場所を気にせずおしゃべりしましょう！",
        online: true,
        permission: permission,
        guest_allowed: guest,
        event_languages_attributes: [
          {
            language_id: 184,
            max: max
          },
          {
            language_id: language_ids[0],
            max: max
          }
        ]
      )

      event.thumbnail.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "seed_online.jpg")), filename: "seed_online.jpg", content_type: 'image/jpg')
    end
  end

end
