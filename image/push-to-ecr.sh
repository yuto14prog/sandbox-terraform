#!/bin/bash

set -e

# 設定
REPOSITORY_NAME="test-image"
IMAGE_TAG="${1:-latest}"

# カラー出力用
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}ECRへのDockerイメージプッシュスクリプト${NC}"
echo -e "${BLUE}========================================${NC}"

# AWSアカウントIDとリージョンを取得
echo -e "\n${GREEN}1. AWS情報を取得中...${NC}"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
AWS_REGION=$(aws configure get region)

if [ -z "$AWS_REGION" ]; then
    AWS_REGION="ap-northeast-1"
    echo -e "${BLUE}リージョンが設定されていないため、デフォルトで ${AWS_REGION} を使用します${NC}"
fi

echo -e "   アカウントID: ${AWS_ACCOUNT_ID}"
echo -e "   リージョン: ${AWS_REGION}"
echo -e "   リポジトリ名: ${REPOSITORY_NAME}"
echo -e "   イメージタグ: ${IMAGE_TAG}"

# ECRのURLを構築
ECR_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
FULL_IMAGE_NAME="${ECR_URL}/${REPOSITORY_NAME}:${IMAGE_TAG}"

# ECRにログイン
echo -e "\n${GREEN}2. ECRにログイン中...${NC}"
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URL}

# Dockerイメージをビルド
echo -e "\n${GREEN}3. Dockerイメージをビルド中...${NC}"
cd "$(dirname "$0")"
docker build -t ${REPOSITORY_NAME}:${IMAGE_TAG} .

# イメージにECRタグを付与
echo -e "\n${GREEN}4. イメージにECRタグを付与中...${NC}"
docker tag ${REPOSITORY_NAME}:${IMAGE_TAG} ${FULL_IMAGE_NAME}

# ECRにプッシュ
echo -e "\n${GREEN}5. ECRにプッシュ中...${NC}"
docker push ${FULL_IMAGE_NAME}

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}✓ 完了しました!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "イメージ: ${FULL_IMAGE_NAME}"
echo -e "\nECSタスク定義を更新するか、ECSサービスを再起動してください。"
