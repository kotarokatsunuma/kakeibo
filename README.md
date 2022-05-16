## アプリケーション名
---------------------------------------

## アプリケーション概要
---------------------------------------
家計簿を管理することができる。


## URL
---------------------------------------

https://kakeibo-37334.herokuapp.com/


## テスト用アカウント
---------------------------------------

・Basic認証パスワード : 2222
<br>・Basic認証ID : admin
<br>・メールアドレス : hoge@hoge
<br>・パスワード : 11111a


## 利用方法
---------------------------------------
## 家計簿投稿
---------------------------------------
1.トップページのヘッダーからユーザー新規登録を行う
<br>2.新規ボタンから、家計簿の内容(年度・月・区分・科目・金額)を入力し登録する

## アプリケーションを作成した背景
---------------------------------------
職場の友人に課題をヒアリングし、「貯金を継続できない」という課題を抱えていることが判明した。課題を分析した結果、「お金を何にどれくらい使っているかわからない」ということが原因であると仮説を立てた。同様の問題を抱えている方も多いと推測し、真因を解決するために、家計簿を簡単につけられるアプリケーションを開発することにした。

## 洗い出した要件
---------------------------------------
[要件を定義したシート](https://docs.google.com/spreadsheets/d/18ggZ-GbZhTyRkw0_PtnTsEn-HSxpAa-IaI6atrTcmBM/edit#gid=982722306)

## 実装した機能についての画像やGIFおよびその説明
---------------------------------------
○フラッシュメッセージ
<br>・登録成功・失敗した時に、画面にメッセージが表示される
[![Image from Gyazo](https://i.gyazo.com/84e95f32df8b85f447b179bf0ff65c34.gif)](https://gyazo.com/84e95f32df8b85f447b179bf0ff65c34)

[![Image from Gyazo](https://i.gyazo.com/cdf7a0d20d3f2c17464719c8be7a609b.gif)](https://gyazo.com/cdf7a0d20d3f2c17464719c8be7a609b)

○検索機能
<br>・年度、対象月を入力し検索ボタンを押すと検索することができる

[![Image from Gyazo](https://i.gyazo.com/2253b17ec2ce527ca2ce7786e2ecd19b.gif)](https://gyazo.com/2253b17ec2ce527ca2ce7786e2ecd19b)

○収入合計、支出合計が自動で計算される

[![Image from Gyazo](https://i.gyazo.com/33b8fe273a101a19c85f60886270ea71.png)](https://gyazo.com/33b8fe273a101a19c85f60886270ea71)

○データを削除しようとすると、確認用の画面が表示される。

[![Image from Gyazo](https://i.gyazo.com/7f72c6791576c77cd92e2deeb2c12fdf.gif)](https://gyazo.com/7f72c6791576c77cd92e2deeb2c12fdf)

## データベース設計
---------------------------------------

[![Image from Gyazo](https://i.gyazo.com/0c660712c13707f1cb6e86e952821e32.png)](https://gyazo.com/0c660712c13707f1cb6e86e952821e32)

## 画面遷移図
---------------------------------------

[![Image from Gyazo](https://i.gyazo.com/eb2b02852e379c5159c29711ca8ec578.png)](https://gyazo.com/eb2b02852e379c5159c29711ca8ec578)

## 開発環境
---------------------------------------
・Ruby 
<br>・Ruby on Rails
<br>・MySQL
<br>・GitHub
<br>・Heroku
<br>・Visual Studio Code

## ローカルでの動作方法
---------------------------------------
以下のコマンドを順に実行。
<br>% git clone https://github.com/kotarokatsunuma/kakeibo.git
<br>% cd kakeibo
<br>% bundle install
<br>% yarn install
<br>% rails db:create
<br>% rails db:migrate
<br>% rails s

## 工夫したポイント
---------------------------------------
家計簿は続けることが大事だと思い、使いやすいシンプルさを追求した。ビュー作成においてはシンプルかつデザイン性を高める為に、Bootstrapを使用した。また、アプリ内に検索機能やflashを使ったメッセージの表示などを実装することでわかりやすく使えるように工夫した。ここに関して、あまり使い慣れていない機能だったので調べながらの実装に苦労した点になった。
実装の際は、エラーが起きてもすぐ対処できるようにする為に、機能ごとにデプロイし、本番環境で動作確認しながら進めた。

