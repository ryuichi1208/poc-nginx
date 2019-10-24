# poc-nginx
docker-compose network for nginx verification.

## Image

![image](https://github.com/ryuichi1208/poc-nginx/blob/master/doc/images/image.png)

## 対応してる機能

* SSLオフロード
* Server Name Indication
* http/2

## 必要

* Mac for Docker

## コンテナごとの説明

* poc => httpクライアント/その他調査用コマンド実行用

## 始め方

```
# コンテナのビルド/証明書の生成
$ make build
```
