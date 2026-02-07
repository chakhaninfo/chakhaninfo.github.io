#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# 변수 설정 (환경 변수로 덮어쓰기 가능)
S3_BUCKET_NAME="${S3_BUCKET_NAME:-chakhan}"
CLOUDFRONT_ID="${CLOUDFRONT_ID:-EU7DRC49E7MLS}"
DEPLOY_FOLDER="${DEPLOY_FOLDER:-public}"
CLEANUP_LOCAL="${CLEANUP_LOCAL:-true}"

log() { printf '%s\n' "$*"; }
die() { printf 'Error: %s\n' "$*" >&2; exit 1; }
require_cmd() { command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"; }

require_cmd aws

# Node 17 확인 및 nvm 사용
ensure_node_17() {
  local node_major

  if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    # shellcheck disable=SC1090
    source "$HOME/.nvm/nvm.sh"
    nvm use 17 >/dev/null
  fi

  require_cmd node
  node_major="$(node -v | sed 's/^v//' | cut -d. -f1)"
  [[ "$node_major" == "17" ]] || die "Node.js 17 required, current: $(node -v)"
}

ensure_node_17

# Hexo는 로컬 설치를 우선 사용
if [[ -x "./node_modules/.bin/hexo" ]]; then
  HEXO_CMD="./node_modules/.bin/hexo"
elif command -v hexo >/dev/null 2>&1; then
  HEXO_CMD="hexo"
else
  die "Hexo not found. Install it or add to node_modules."
fi

# 1. hexo generate 실행
log "🔧 Hexo generate 실행 중..."
"$HEXO_CMD" generate

[[ -d "$DEPLOY_FOLDER" ]] || die "Deploy folder not found: $DEPLOY_FOLDER"

# 2. public 폴더 S3 업로드 (동기화 + 삭제 반영)
log "🚀 S3로 업로드 중..."
aws s3 sync "$DEPLOY_FOLDER/" "s3://$S3_BUCKET_NAME" --delete

# 3. CloudFront 캐시 무효화 (ID가 있을 때만)
if [[ -n "$CLOUDFRONT_ID" && "$CLOUDFRONT_ID" != "CHANGE_ME" ]]; then
  log "🧼 CloudFront 캐시 무효화 중..."
  aws cloudfront create-invalidation --distribution-id "$CLOUDFRONT_ID" --paths "/*" >/dev/null
fi

# 4. public 폴더 삭제 (옵션)
if [[ "$CLEANUP_LOCAL" == "true" ]]; then
  log "🗑️ $DEPLOY_FOLDER 폴더 삭제 중..."
  rm -rf "$DEPLOY_FOLDER"
fi

log "✅ 배포 완료!"
