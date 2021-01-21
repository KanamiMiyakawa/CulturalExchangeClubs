# README
## デプロイ先（AWS）
http://52.196.243.29/
## 初期データについて
- ユーザ30件、グループ5件、オンラインイベント20件、リアルイベント30件
- languages_table用のデータ（iso693基準の言語DB）

デプロイ先（AWS）では初期データは投入済みです  
地理的に密集したデータを作成するため、ユーザとイベントの住所データは  
**東京都、神奈川県、埼玉県、千葉県** に限定してあります  
ローカルで動かす場合は、最初にrails db:seed RAILS_ENV=developmentをしてください  
ただしローカルではgoogleMapsが使用できないので、全リアルイベントと初期ユーザの住所は生成されません  
### 初期ユーザデータ
- role:グループのオーナー: user_1@example.com ~ user_5@example.com
- role:グループのオーガナイザー: user_6@example.com ~ user_10@example.com
- role:グループのメンバー: user_11@example.com ~ user_20@example.com
- role:なし: user_21@example.com ~ user_30@example.com
- 各ユーザのemailとパスワードは、それぞれのユーザ名と同じです。例えばuser_1@example.comなら、emailとパスワードもuser_1@example.comです
## 異文化話者の交流イベント・プラットフォーム CulturalExchangeClubs(CEC)
### 概要
日本には現在300万人弱の外国人労働者がいますが、彼らは実際の数ほど可視化されておらず、
彼らと現地住人の出会う場は非常に少ないのが実情です。
このアプリは、お互いの言語や文化を学びたい人同士が出会って交流する、
Cultural Exchangeという活動を支援したいと思い作成しました。
まずは我々が触れ合う機会を増やすことで、当たり前に彼らがいる、
お互いが異なりつつも包含し合うような社会が形成されていくことを祈っています。
他のイベントプラットフォームと比較して、言語を軸にした検索、言語を選んでのイベント作成や参加、
イベント詳細の自動翻訳機能などに独自性をを持っています。
### コンセプト
異文化話者同士が参加するイベントに特化したイベント・プラットフォーム
### 独自機能
- 参加者は興味のある言語を選択するだけで、その言語話者を対象とするイベントを検索可能
- イベント企画者は、対象とする言語や、言語ごとの参加人数を決めてイベント作成できる
- マップ機能で登録した住所の一定距離で開催されるイベントを自動検索
- イベント作成時、選択言語でイベント内容の自動翻訳を作成できる
### バージョン
Ruby 2.6.5  
Rails 5.2.4  
PostgreSQL
### 機能一覧
- ログイン機能
- ユーザー登録機能
  - 名前、メールアドレス、パスワードは必須
- グループ作成機能
  - ３つの権限：オーナー(グループに１人、初期は作成者)、オーガナイザー(複数)、一般メンバー(複数)
  - オーナーのみ、オーガナイザーの任命、削除、メンバー削除、オーナーの変更ができる
  - オーガナイザーのできることは、オーナーもできる
  - グループ加入にオーガナイザーの許可を必須にすることができる
- イベント一覧表示・検索機能
  - 現在の日付以降のイベントのみを、近い順に表示
  - キーワード、言語、日付、住所で検索可能
- イベント作成機能（オーガナイザー側）
  - オーガナイザーはイベントの作成、編集、削除、ユーザー参加の許可ができる
  - 名前、日時、場所、言語などを登録可能
  - 開催場所を、各詳細ページにおいて地図上で表示する
  - 選択言語ごとに参加上限人数を設定可能
  - イベント参加にオーガナイザーの許可を必須にすることができる
  - イベント詳細のテキストを、選択言語ごとに自動翻訳して保存できる
- イベント参加機能（ユーザ側）
  - 住所を登録しておくと、その一定範囲内のイベントを一覧ページで自動で表示する
  - 自分が会話できる言語を選択して参加可能
  - グループ加入とイベント参加のリクエストを同時に送信できる
  - サインアップしていない場合、サインアップと同時にリクエストを送信できる（前もってサインアップする必要がない）
### カタログ設計・テーブル定義
https://docs.google.com/spreadsheets/d/11eluuCeg5k4JAjQgzYvo40QRuyTxnY8U9rNCpN-9wyM/edit?usp=sharing
### ER図
https://docs.google.com/presentation/d/1Eiddxr_dBZR8TY2_y5PCtZx599b6kyAeJNIEKaMo5QE/edit?usp=sharing
### 画面遷移図
https://docs.google.com/presentation/d/1Jz8oObH5ubA2wDL1bvhyjnbUclzm5MsA9BRwIt5O0gA/edit?usp=sharing
### ワイヤーフレーム
https://docs.google.com/spreadsheets/d/14cne6lTpEx5Xq9UEWc3DybaPvamztQaa3jEkLzOUYHI/edit?usp=sharing
### 使用技術
- ActiveStorage + S3サーバ
- GoogleMaps
- GoogleCloudTranslation
- AWS(EC2)にデプロイ
- devise
- geocoder
- bootstrap4
- ransack
- gon
- kaminari
- capistrano
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
