# ha4go
## ローカル環境へのインストール手順

###  Facebookにテスト用アプリとして登録(OAuth認証のため登録必須)

Facebook Developers
https://developers.facebook.com/

1. メニュー > My Apps > Add a New App

2. 種別の中から、「ウェブサイト(www)」を選択

3. アプリの名前を入力(ha4go-devなど)

4. カテゴリを適当に選択してCreate App ID でID発行

5. Quick Startとしてコードが出てくるが、ここは飛ばして
"Tell us about your website"
Site URL: "http://localhost:3000/"
Mobile Site URL: "http://localhost:3000/"
を入力してNext

6. メニュー > My Appsに3で入力したアプリ名が出るのでそこからダッシュボードへ

7. "App ID" と "App Secret"を控える

### ローカルに環境構築&サーバー起動

1. リポジトリのインストール
```
git clone https://github.com/jshimazu/ha4go.git
cd ha4go
bundle install --path vendor/bundle --without staging production
rake db:migrate
```

2. 先ほど控えたApp IDとApp Secretを.envというファイルに記載
```
echo "FACEBOOK_APP_ID={App ID}" >> .env
echo "FACEBOOK_APP_SECRET={App Secret}" >> .env
```

ブラウザで
http://localhost:3000 にアクセスして
起動できれば完了！
