#!/bin/bash

set -euo pipefail

if [ $# -gt 0 ]; then
  title="$1"
else
  echo "タイトルを入力してください"
  read -r title
fi

date_prefix="$(TZ=Asia/Tokyo date +%Y%m%d)"
content_name="${date_prefix}_${title}"

echo "CONTENT_NAME=${content_name}"
hugo new -k diary "post/diary/${content_name}/index.md"
