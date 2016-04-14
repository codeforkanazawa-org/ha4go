# ha4go
## ローカル環境へのインストール手順

# 依存の確認
git, docker, rubyなど

# ソースコードの取得と準備

``` shell
git clone https://github.com/codeforkanazawa-org/ha4go.git
cd ha4go
bundle install --path vendor/bundle
```

# dbの準備

**注意このMySQLは公式Dockerのrootパスワードそのままなど安全ではないですので運用には充分気をつけて下さい**

``` shell
rake -f Rakefile.deploy build[db]     # image build
rake -f Rakefile.deploy run[db,DEBUG] # start mysql
```

これで `localhost` か `docker-machine ip` に MySQL が準備できるので

``` shell
export MYSQL_HOST=localhost # or `docker-machine ip default` など
```

dbを作成する。

``` shell
mysql -uroot -p1234 -h$(MYSQL_HOST) < init.sql
```

マイグレーションする

``` shell
rake db:migrate
```

# Facebookにテスト用アプリとして登録(OAuth認証のため登録必須)

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

# .env を作成する

先ほど控えたApp IDとApp Secretを.envというファイルに記載

```
echo "FACEBOOK_APP_ID={App ID}" >> .env
echo "FACEBOOK_APP_SECRET={App Secret}" >> .env
```


### ローカルに環境構築&サーバー起動

```
bundle exec rails s
```

その後、ブラウザで `http://localhost:3000` で画面が見えれば成功。
