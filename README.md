# poc-nginx
docker-compose network for nginx verification.

## 概要

Nginxを使ったwebアプリケーションの設定のテストをするためのリポジトリ

## 対応機能

* SSLオフロード(SSLアクセラレータ)
* Server Name Indicationテスト
* リバースプロキシバッファやキャッシュを用いた動作確認

## 必要ソフトウェア

* make
* Docker / docker-compose

## 始め方

```
# コンテナのビルドと環境セットアップ
$ make build
```
