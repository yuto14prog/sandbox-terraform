# ECS Test Docker Image

このディレクトリには、ECS Fargateで動作するテスト用のDockerイメージが含まれています。

## 構成

- `Dockerfile`: nginx:alpine ベースのシンプルなWebサーバー
- `index.html`: テスト用のHTMLページ
- `push-to-ecr.sh`: ECRへのイメージプッシュスクリプト

## 使用方法

### 前提条件

- Docker がインストールされていること
- AWS CLI がインストール・設定されていること
- ECRリポジトリが作成されていること（Terraformで作成済み）
- 適切なAWS認証情報が設定されていること

### ECRへのプッシュ

```bash
cd image
./push-to-ecr.sh
```

特定のタグを指定する場合:

```bash
./push-to-ecr.sh v1.0.0
```

### ローカルでのテスト

```bash
cd image
docker build -t test-image .
docker run -p 8080:80 test-image
```

ブラウザで `http://localhost:8080` を開いてテストページを確認できます。

## スクリプトの動作

`push-to-ecr.sh` は以下の処理を自動的に実行します:

1. AWS情報（アカウントID、リージョン）の取得
2. ECRへのログイン
3. Dockerイメージのビルド
4. イメージへのECRタグ付与
5. ECRへのプッシュ

## トラブルシューティング

### ECRログインエラー

AWS認証情報が正しく設定されているか確認してください:

```bash
aws sts get-caller-identity
```

### リージョンの変更

デフォルトでは `ap-northeast-1` が使用されます。変更する場合は:

```bash
aws configure set region <your-region>
```

または、スクリプト内の `AWS_REGION` を直接編集してください。
