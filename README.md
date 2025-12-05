# sandbox-terraform

よく使う検証用のインフラ環境をパッと立てられるようにするプロジェクト

## 初期設定

1. tfenvのインストール

```bash
brew install tfenv
```

2. Terraformのインストール

.terraform-versionによってterraformのバージョンが自動選択されます。

```bash
tfenv install
tfenv use
```

3. AWSプロファイルの設定

```bash
# AWS CLIの設定
aws configure --profile sandbox

# 以下の情報を入力
# AWS Access Key ID: [アクセスキーID]
# AWS Secret Access Key: [シークレットアクセスキー]
# Default region name: ap-northeast-1
# Default output format:
```

4. Terraformの初期化

```bash
cd resources
terraform init
```
