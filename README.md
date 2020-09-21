# neuron

## 概要
問いかけ(que)機能とまとめ(map)機能を特徴としたSNSです。  
postやqueを使って情報を発信・収集し、それをmap上で図式化、共有するというプロセスを通じて  
自分の考えも他者の考えも相互に掘り下げられる場を目指しました。

## コンセプト
「人を知り、自分を知る」をコンセプトとしたアプリです。  
質問を投げかけ、不特定多数の意見を集約することで相対的に自分の立ち位置を認識したいと考える事が多いのですが、  
既存のQ&Aサービスは「解説してもらう」ことに向いていて「意見を募る」には質問や回答の手間が多い、  
既存のSNSでは多くの繫がりを作っておかないと回答者の母数を稼ぎにくい、という点から  
問いかけるのも答えるのも簡単・最小限の労力で沢山の回答が貰えるアンケートSNSを作ろうと思ったのが原点です。  
また、「SNSのまとめ」の記事や作成サービスが長く使用されていることから、その利便性や面白さに着目し、
「人を知り、自分を知る」を強化するまとめ機能を作ろうと考えました。
自他の投稿を再利用してマインドマップ状のまとめ(map)を作成でき、それによって思考の整理や掘り下げを行い、  
公開されたmapを閲覧することで人の思考を体系的に知ることが出来ます。  
それらの機能を用いて、内的世界が繋がっていくような情報のやり取りを実現したいと考えました。

## バージョン情報
- Docker 19.03.8
- Ruby 2.6.5
- Ruby on Rails 5.2.4.3
- PostgreSQL 12.3

## 使用技術
- Ruby
- Ruby on Rails
- Docker
- Nignx
- Unicorn
- AWS(EC2,S3)

## 機能一覧
- アカウント登録機能
  - 氏名、メールアドレス、パスワードを使用
- ログイン・ログアウト機能
- ゲストログイン機能
- プロフィール作成機能
  - ID・表示名・プロフィールが登録可能
- post機能
- que機能
- map機能
- フォロー機能
- お気に入り機能
- コメント機能
- 検索機能
- メッセージ機能
- リンク機能
- 通知機能
- 管理機能

## カタログ設計
https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_HItL3TKOxXnaYs4iP0PqUh3RsVLCP6kwW4sVVccpcblpFS-cxZD33Lds5ex3Xa7MMKmIixltlG0r/pubhtml?gid=0&single=true

## テーブル定義書
https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_HItL3TKOxXnaYs4iP0PqUh3RsVLCP6kwW4sVVccpcblpFS-cxZD33Lds5ex3Xa7MMKmIixltlG0r/pubhtml?gid=845166345&single=true

## ER図
https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_HItL3TKOxXnaYs4iP0PqUh3RsVLCP6kwW4sVVccpcblpFS-cxZD33Lds5ex3Xa7MMKmIixltlG0r/pubhtml?gid=1559826394&single=true

## 画面遷移図
https://docs.google.com/spreadsheets/d/e/2PACX-1vQ_HItL3TKOxXnaYs4iP0PqUh3RsVLCP6kwW4sVVccpcblpFS-cxZD33Lds5ex3Xa7MMKmIixltlG0r/pubhtml?gid=1674423056&single=true

## ワイヤーフレーム
https://docs.google.com/spreadsheets/d/e/2PACX-1vRTamouc98XEhGfib4Rr9qgjaedyu_U5_Kvl8QRE4oXoPjLgvie4BK_gli3M-HC6ysAzMEG-kpNmZq5/pubhtml

## 環境構築/起動方法
1. Dockerを公式サイトよりダウンロード・インストールします。

2. 以下のコマンドを実行します。
```
$ git clone https://github.com/thkiyose/neuron.git
$ cd neuron
$ docker-compose build
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
$ docker-compose up -d
```

3. ブラウザにて以下のディレクトリにアクセスします。
```
localhost:3000
```

## 使用予定Gem
- ransak
- mini_magik
- devise
- letter_opener_web
- pundit
- kaminari
- slim-rails
- public_uid
