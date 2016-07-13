# ha4go
# ローカル環境へのインストール手順

# 依存の確認
Git, docker, Ruby, MySQL など

# ソースコードの取得と準備

``` shell
git clone https://github.com/codeforkanazawa-org/ha4go.git
cd ha4go
bundle install --path vendor/bundle
```

# .env ファイルの準備

ha4goをカスタムするデータのいくつかは環境変数を経由して指定します。 `dotenv` を採用しているので開発には `cp .env.sample .env` し、内容を変更して使って下さい。現時点では全ての値を設定する必要があります(省略できません、実際に存在するsmtpサーバなどを指定する必要があります)

``` bash
cp .env.sample .env
vim .env
```

現時点では以下のデータを用意する必要があります。

``` .env
FACEBOOK_APP_ID=12341234
FACEBOOK_APP_SECRET="hogehogehoge"
SMTP_SERVER='smtp.gmail.com'
SMTP_PORT=587
SMTP_DOMAIN='googleapps.domain'
SMTP_USER='notifier_user@googleapps.domain'
SMTP_PASSWORD='password_of_notifier_user'
APP_HOST=localhost:3000
MYSQL_HOST=localhost
```


# dbの準備

現在、環境が `production` だろうが `development` だろうが、MySQL を用いています。


## MySQL を用いる場合

MySQLをインストールし、 `init.sql` を参考にして db と ha4go用ユーザーを 作成してください。下記は OSX で一番簡単な例です。

``` shell
mysql.server start          # start mysql
mysql -uroot -p < init.sql  # create db & user
export MYSQL_HOST=localhost # (or edit .env)
bundle exec rake db:setup   # setup database
```


## Docker 上の MySQL を用いる場合

**注意このMySQLは公式Dockerのrootパスワードそのままなど安全ではないですので運用には充分気をつけて下さい**

``` shell
bundle exec rake -f Rakefile.deploy build[db]     # image build
bundle exec rake -f Rakefile.deploy run[db,DEBUG] # start mysql
```

これで Linuxなら `127.0.0.1` か `docker-machine ip` に MySQL が準備できるのでこれで接続します。(`127.0.0.1`ではなく、`localhost` を用いると、MySQLが自動的に UNIX ドメインソケットが用いてしまい、接続エラーになります)

`init.sql` を参考にして db と ha4go用ユーザーを 作成してください。

``` shell
export MYSQL_HOST=127.0.0.1                    # or =`docker-machine ip`
mysql -uroot -p1234 -h$(MYSQL_HOST) < init.sql # create db & user
bundle exec rake db:migrate                    # migrate database
```


# Facebook App ID の準備

Facebook にテスト用アプリとして登録(OAuth認証のため登録必須)してください。

Facebook Developers
https://developers.facebook.com/

1. メニュー > My Apps > Add a New App
2. 種別の中から、「ウェブサイト(www)」を選択
3. アプリの名前を入力(ha4go-devなど)
4. カテゴリを適当に選択してCreate App ID でID発行
5. Quick Startとしてコードが出てくるが、ここは飛ばして以下を入力してNext
  - "Tell us about your website"
  - Site URL: `http://localhost:3000/`
  - Mobile Site URL: `http://localhost:3000/`
6. メニュー > My Appsに3で入力したアプリ名が出るのでそこからダッシュボードへ
7. "App ID" と "App Secret"を控えておいて、 `.env` や 環境変数で用いて下さい

``` .env
FACEBOOK_APP_ID={App ID}"
FACEBOOK_APP_SECRET={App Secret}
```


# SMTP の準備

Gmailがそのまま使えるので、アカウントを取得して設定してください。(Gmailの場合の SMTP_DOMAINは `smtp.gmail.com` です)


# ローカルでサーバー起動

```
bundle exec rails s
```

その後、ブラウザで `http://localhost:3000` で画面が見えれば成功。
