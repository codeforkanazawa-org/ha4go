# Ha4go とは

[Ha4go](http://codeforkanazawa-org.github.io/ha4go/) を参照してください。


# ライセンス

本アプリ及びソースコードの著作権はCode for Kanazawaに帰属します。 但し、このソースコードは[MPL 2.0](https://www.mozilla.org/en-US/MPL/2.0/)のもと配布されています。MPLに従えば、どなたでも利用、改変、及び再配布が可能です。

# 貢献する方法


## ご意見・ご要望・バグレポート

本リポジトリの [`issues`](https://github.com/codeforkanazawa-org/ha4go/issues/new) 経由でご連絡ください。


## 実装

本リポジトリをフォークして作業し、デプロイ可能な状態になりましたら GitHub 上から `master` プルリクエストをください。本リポジトリ運用チームが対応いたします。開発環境の作成は、後述する "ローカル環境での開発環境作成" 及び "heroku での開発環境作成" を参照してください。

様々な団体などに対応できるように Code for Kanazawa 依存の部分はなく、フォーク & 環境変数ですべてカスタム可能なように作ってあります。プルリクエスト時にはこの原則を守っていただけるようお願いします。


### 本リポジトリにおけるブランチの運用

| ブランチ名      | 概要                                                             |
|:----------------|:-----------------------------------------------------------------|
| `master`        | デプロイ可能な状態のものです                                     |
| `release`       | Code for Kanazawa 向けにデプロイした際、ここにマージします       |
| `gh-pages`      | コードとは独立した Ha4go についてのドキュメント(`orphan branch`) |
| `heroku_master` | `master` へのマージ前にデザイナ確認用ブランチ                    |

上記以外は各自にまかせます。


# ローカル環境での開発環境作成

## 依存

下記のツールやサーバに依存しています。各自で準備してください(準備方法は後述してあります)。

- Ruby on Rails 4
- MySQL サーバ
- SMTP サーバ
- Facebook アプリ


## ソースコードの取得と準備

``` shell
$ git clone https://github.com/codeforkanazawa-org/ha4go.git
$ cd ha4go
$ bundle install --path vendor/bundle
```


## .env ファイルの準備

Ha4goをカスタムするデータのいくつかは環境変数を経由して指定します。 `dotenv` を採用しているので開発には `cp .env.sample .env` し、内容を変更して使って下さい。現時点では全ての値を設定する必要があります(省略できません、実際に存在するsmtpサーバなどを指定する必要があります)

``` bash
$ cp .env.sample .env
$ vim .env
```

現時点では以下のデータを用意する必要があります。入力する値は後述する各準備を確認してください。

``` .env
FACEBOOK_APP_ID=12341234
FACEBOOK_APP_SECRET="hogehogehoge"
DELIVERY_METHOD=letter_opener_web
SMTP_SERVER='smtp.gmail.com'
SMTP_PORT=587
SMTP_DOMAIN='googleapps.domain'
SMTP_USER='notifier_user@googleapps.domain'
SMTP_PASSWORD='password_of_notifier_user'
APP_HOST=localhost:3000
MYSQL_HOST=127.0.0.1
MYSQL_USER=ha4go
MYSQL_PW=ha4goha4go
USE_HTTPS=0
```


## Facebook App ID の準備

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


## HTTPSを用いる場合

nginxなどのリバースプロキシを使い、ローカル以外にデプロイしてHTTPSを用いる場合、

```
USE_HTTPS=1
```

としてください。内部的にリンクを作成する際、 `https://` が採用されるようになります。


## SMTP の準備

`DELIVERY_METHOD=` でメール送信方法を選択します。

開発時には `letter_opener_web` が指定できます。これを指定するとメールは送信されず、サーバの用意も必要ありません。加えて `http://localhost:3000/letter_opener` で擬似的に送信したメールを確認することができます(開発時のみ有効なURLです)。この場合は `SMTP_` からはじまる全ての環境変数は無視されます。

運用配置など実メールを用いる場合には `smtp` を指定して、メールサーバを用意してください。Gmailがそのまま使えるので、アカウントを取得して設定すると楽です。(Gmailの場合の SMTP_DOMAINは `smtp.gmail.com` です)

```
DELIVERY_METHOD=smtp
```


## DBの準備

現在、環境が `production` だろうが `development` だろうが、MySQL を用いています。以下の3つの方法から、好きなものを使って下さい。


### 直接 MySQL を用いる場合

MySQLをインストールし、 `init.sql` を参考にして db と Ha4go用ユーザーを 作成してください。下記は OSX で一番簡単な例です。

``` shell
mysql.server start          # start mysql
mysql -uroot -p < init.sql  # create db & user
export MYSQL_HOST=localhost # (or edit .env)
bundle exec rake db:setup   # setup database
```


### Docker の MySQL を用いる場合

MySQLをビルドし、用います。 `docker-machine` などを用いている場合、リモートホストの接続制限でユーザ `root` でアクセスできません。

**注意このMySQLは公式Dockerのrootパスワードそのままなど安全ではないですので運用には充分気をつけて下さい**

``` shell
bundle exec rake -f Rakefile.deploy build[db]     # image build
bundle exec rake -f Rakefile.deploy run[db,DEBUG] # start mysql
export MYSQL_HOST=`docker-machine ip default`     # docker-machineの場合、Linuxの場合は 127.0.0.1 など
mysql -uroot -h$MYSQL_HOST -p < init.sql          # create db & user
bundle exec rake db:setup
```

以後は `bundle exec rake -f Rakefile.deploy run[db,DEBUG]` で開始できます。


### Docker Compose を用いる場合

後述するアプリの起動で同時に行えます。 


## アプリの開始

### 直接ローカルで動かす場合

```
bundle exec rails s
```

その後、ブラウザで `http://localhost:3000` で画面が見えれば成功。メール送信・SNSへポストなど非同期実行するものは以下のコマンドでActive Jobを動かしてください。

```
bundle exec rake jobs:work
```

### ローカル環境にダミーデータを用意する

開発をスムーズにするため、`db/seeds/モデル名.yml.sample` に記述されているダミーデータを開発用に利用することができます。

以下のコマンドからダミーデータを入れることが可能です。

```
bundle exec rake db:seed:unlock_yml
bundle exec rake db:seed
```

ha4go は Facebook ログインを利用しているため、 `uid` はその Facebook が払い出したIDを本来用いないといけませんが、__db/seeds/users.yml.sample__ ではダミーの値を用いてます。この値を使っても Facebook と連携はとれません。


### Docker 上でアプリを動かす場合

(現在準備中、後述する docker-compose を使うことをお薦めします)


### Docker Composeを用いる場合

docker-compose を使うと、db と web 両方の環境を立ち上げてくれます`.env` ファイルは `MYSQL_HOST=db` としておいてください。

**注意このMySQLは公式Dockerのrootパスワードそのままなど安全ではないですので運用には充分気をつけて下さい**

``` shell
eval $(docker-machine env) # docker-machineを用いている場合
docker-compose build
docker-compose up
export MYSQL_HOST=`docker-machine ip default` # docker-machineの場合、Linuxの場合は 127.0.0.1 など
mysql -uroot -h$MYSQL_HOST -p < init.sql      # create db & user
```

db の初期設定は以下の手順で行ってください。

``` shell
docker-compose run --rm web bundle exec rake db:setup # dbの作成, migrate, seed の投入
```

この状態で、`docker-machine ip`:3000 にブラウザでアクセスするとページが見れるようになります。

基本的に、rails コマンドなど他のものを実行したい場合も、上記のように`docker-compose run --rm web bundle exec`の後につければ実行できます。

#### Sequel Pro などでDBに直接アクセスしたい

できます! 3306ポートをマッピングしてありますので、`docker-machine ip` で取得できるIPアドレスの3306番にアクセスしてください。

### サーバの再起動

`docker-compose up` を実行しているプロセスを、Ctrl+C で止めて、再度 `docker-compose up` を実行してください。


# heroku での開発環境作成

macOS を前提として書いています。おそらく Ubuntu などでもできると思います。

## CLIのセットアップ

アカウント取得し、CLIツールのインストールを行ってください。 

[Heroku Command Line | Heroku Dev Center](https://devcenter.heroku.com/articles/heroku-command-line)

`heroku version` で問題なくツールのバージョンを取得できることを確認してください。

## ソースコードの取得と準備

``` shell
$ git clone https://github.com/codeforkanazawa-org/ha4go.git
$ cd ha4go
$ bundle install --path vendor/bundle
```

## アプリの作成とDB設定

clone したディレクトリに移り、アプリ作成、DB設定など下記の用に行います

``` shell
$ cd ha4go # 前述の bundle install した ディレクトリです
$ heroku create
$ heroku config | grep CLEARDB_DATABASE_URL # これで mysql://.+ を確認
$ heroku config:set DATABASE_URL=mysql2://(上の.+の値を用いる)
```

## 環境変数の設定

前述した `ローカル環境へのインストール手順` の `.env ファイルの準備` で指定する内容を準備して設定します。
不必要なものもあるので、下記の内容のみを各自の用意した値で行ってください。

``` shell
$ heroku config:set FACEBOOK_APP_ID=12341234
$ heroku config:set FACEBOOK_APP_SECRET=hogehogehoge
$ heroku config:set SMTP_SERVER=smtp.gmail.com
$ heroku config:set SMTP_PORT=587
$ heroku config:set SMTP_DOMAIN=googleapps.domain
$ heroku config:set SMTP_USER=notifier_user@googleapps.domain
$ heroku config:set SMTP_PASSWORD=password_of_notifier_user
$ heroku config:set DELIVERY_METHOD=smtp
```

## デプロイ

``` shell
$ git push heroku            # デプロイ
$ heroku run rake db:setup   # データベースマイグレーション & 初期値の設定
$ heroku open                # ブラウザで開いてみる
$ heroku logs                # ログの確認
$ heroku run rake db:migrate # 以降イテレーション時に必要あれば
```

同ディレクトリで `git push heroku` をすればデプロイされます。データベースのマイグレーションや初期データの設定を行う必要がある場合(最初のデプロイ時には必ず必要です)には `heroku run rake db:setup` を同ディレクトリで行ってください。

### Deploy to Heroku ボタンでのデプロイする

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy) をクリックすることでHerokuデプロイが容易にできます。

その場合、

- 画像保存で利用するファイルストレージの設定（デフォルトではAmazon S3を指定しています）
- メール配信サービスの設定（デフォルトではSendGridを指定しています。[設定方法](https://devcenter.heroku.com/articles/sendgrid)）
- [データベースの設定](https://devcenter.heroku.com/articles/cleardb#configuring-your-ruby-application-to-use-cleardb)

が必要になります。


# 運用

運用時にはSSL証明書を用いることを強く推奨します。

`<団体名>.ha4go.net` で運用したい場合にはDNSを設定しますので[Issues · codeforkanazawa-org/ha4go](https://github.com/codeforkanazawa-org/ha4go/issues)経由で下記を明記の上連絡ください。確認でき次第設定いたします。

- 団体名と連絡先
- 設定したい団体名( `<団体名>.ha4go.net` となります)
- IPアドレスもしくはCNAME

SSL証明書については `*.ha4go.net` をEV証明書を取得して運用して **おりません** ので、各自で運用したい `<団体名>.ha4go.net` の証明書を取得・運用してください。
