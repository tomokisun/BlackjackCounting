#!/bin/bash

# 変更する MARKETING_VERSION の値
NEW_VERSION=$(date '+%y').$(date '+%m').$(date '+%d')

# project.pbxproj ファイルのパス
PDXPROJ_FILE="BlackjackCounting.xcodeproj/project.pbxproj"

# MARKETING_VERSION の行を探すパターン
VERSION_PATTERN="MARKETING_VERSION ="

# MARKETING_VERSION の行を置き換えるための文字列
REPLACEMENT="MARKETING_VERSION = $NEW_VERSION;"

# ファイル内の MARKETING_VERSION を書き換える
sed -i '' "s/$VERSION_PATTERN.*/$REPLACEMENT/g" "$PDXPROJ_FILE"

echo "MARKETING_VERSION が $NEW_VERSION に書き換えられました。"
