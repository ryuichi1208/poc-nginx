# poc-nginx
docker-compose network for nginx verification.

## Constitution

* Docker/Docker-compose
* Nginx
* Python/Flask/uWsgi

## Commands

``` bash
# Build and Start
$ make build

# Restart
$ make restart

# Nginx reload
$ make reload
```

## リバースプロキシ設定

#### upstream

```
# 接続アルゴリズム
* 重み付きラウンドロビン (デフォルト)
* least_conn : 重み考慮の上最小のコネクション数へ接続
* ip_hash : IPアドレスのハッシュで比較。同じクライアントは同じバックエンドへ接続

# 切り離し
max_fails : 失敗回数を指定(fail_timeoutで指定した時間内にこの回数失敗すると切り離される)
fail_timeout : タイムアウト発生時間の指定と切り離し時間を指定する
```

#### location

```
# proxy_hide_header
ヘッダ情報を削除する

# proxy_connect_timeout 75s;
バックエンドへコネクトを貼る際のタイムアウト時間を指定

# proxy_send_timeout 10s;
データを送信する際のタイムアウト値

# proxy_read_timeout 10s;

# proxy_next_upstream

```

#### API

```
curl -XGET -sv http://localhost:8080/uri/test/sleep\?st\=3
curl -XPOST -d "st:2" -sv http://localhost:8080/uri/test/sleep
```
