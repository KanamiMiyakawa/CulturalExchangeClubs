# README
## 異文化交流イベントマッチングサイト CulturalExchangeClubs(CEC)
### 概要
外国語を学びたい日本語話者と、日本語を学びたい外国語話者が出会う
Cultural Exchangeは、お互いのニーズが合わさった素晴らしい場所です
このアプリでは、まだCultural Exchangeを知らない方にも
このイベントがどんなものか紹介し、簡単に企画・参加できるようにご案内します
またCultural Exchangeに特化しているため、他のアプリよりも言語での
検索や翻訳機能に強みを持っています
### コンセプト
他言語話者同士が参加するイベントに特化したマッチングサイト
### バージョン
Ruby 2.6.5
Rails 5.2.4
PostgreSQL
### 機能一覧
- ログイン機能
- ユーザー登録機能
  - 名前、メールアドレス、パスワードは必須
  - 住所登録はGoogleMapsAPIを使用前提
- グループ作成機能
  - 主オーガナイザー、オーガナイザー、一般メンバーの３つの権限
  - ユーザ加入にオーガナイザーの許可を必須にすることができる
- イベント一覧表示機能
  - 日付の近い順にイベントを表示
  - キーワード、地域、言語、日付で検索可能
- イベント作成機能（オーガナイザー側）
  - 名前、日時、場所を登録可能
  - 対象言語と上限人数を設定可能
  - ユーザ参加にオーガナイザーの許可を必須にすることができる
  - 作成、編集、削除時にグループメンバーにメールを送信する
- イベント参加機能（ユーザ側）
  - 自分が話す言語を選択して参加可能
  - イベントに対してコメント可能
  - イベント後に簡単な評価をつけられる
### カタログ設計・テーブル定義
https://docs.google.com/spreadsheets/d/11eluuCeg5k4JAjQgzYvo40QRuyTxnY8U9rNCpN-9wyM/edit?usp=sharing
### ER図
https://drive.google.com/file/d/11nVrJr90whg0hjzZeKEhYAPqkRGA_vp7/view?usp=sharing
### 画面遷移図
https://drive.google.com/file/d/1v8iBK1jg0eVJJbOrL1BksWQxt05RNZ2x/view?usp=sharing
### ワイヤーフレーム
https://docs.google.com/spreadsheets/d/14cne6lTpEx5Xq9UEWc3DybaPvamztQaa3jEkLzOUYHI/edit?usp=sharing
### 使用予定gem
- devise
- ransack
- font-awesome-sass
### 使用予定API
- GoogleMapsAPI
- GoogleCloudTranslationAPI
