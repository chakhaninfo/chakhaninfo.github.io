#!/bin/bash

# 변수 설정
S3_BUCKET_NAME="chakhan"
CLOUDFRONT_ID="EU7DRC49E7MLS"
DEPLOY_FOLDER="public"

# 1. hexo generate 실행
echo "🔧 Hexo generate 실행 중..."
hexo g

# 2. S3 버킷 비우기
echo "🧹 S3 버킷 비우는 중..."
aws s3 rm s3://$S3_BUCKET_NAME --recursive

# 3. public 폴더 S3 업로드
echo "🚀 S3로 업로드 중..."
aws s3 sync ./$DEPLOY_FOLDER s3://$S3_BUCKET_NAME

# 4. public 폴더 삭제
echo "🗑️ $DEPLOY_FOLDER 폴더 삭제 중..."
rm -rf $DEPLOY_FOLDER

echo "✅ 배포 완료!"