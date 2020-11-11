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
- グループ作成機能
  - 主オーガナイザー、オーガナイザー、一般メンバーの３つの権限
  - ユーザ加入にオーガナイザーの許可を必須にすることができる
- イベント一覧表示機能
  - 日付の近い順にイベントを表示
  - キーワード、言語、日付で検索可能
- イベント作成機能（オーガナイザー側）
  - 名前、日時、場所を登録可能
  - 開催場所を、各詳細ページにおいて地図上で表示する
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
https://docs.google.com/presentation/d/1Eiddxr_dBZR8TY2_y5PCtZx599b6kyAeJNIEKaMo5QE/edit?usp=sharing
### 画面遷移図
https://docs.google.com/presentation/d/1Jz8oObH5ubA2wDL1bvhyjnbUclzm5MsA9BRwIt5O0gA/edit?usp=sharing
### ワイヤーフレーム
https://docs.google.com/spreadsheets/d/14cne6lTpEx5Xq9UEWc3DybaPvamztQaa3jEkLzOUYHI/edit?usp=sharing
### 使用予定gem
- devise
- ransack
- font-awesome-sass
### 課題要件
- 就業Termから２つ以上の技術
  - devise
  - AWS
- カリキュラム外から１つ以上の技術
  - ransack
  - GoogleMapsAPI
    - イベントの開催場所を、各詳細ページにおいて地図上で表示する（優先度：高）
    - ユーザが登録した住所から一定距離内のイベントを検索し、一覧画面の地図上で表示する（優先度：中）
  - GoogleCloudTranslationAPI
    - イベント詳細のテキストを選択した言語に自動翻訳して保存（優先度：中）
