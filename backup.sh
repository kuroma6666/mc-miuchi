#!/bin/sh

#設定ファイル読み込み
. ./bot_config.txt

# コピー元からコピー先へディレクトリごとコピー
cp -rp /opt/minecraft /media/share_minecraft

echo Backup Done

# コピー先へ移動
cd /media/share_minecraft

# コピー先ディレクトリを圧縮
tar cfzP `/bin/date +%Y-%m-%d`_mc-miuchi.tar.gz minecraft

echo Compression Done


rm -rf /media/share_minecraft/minecraft
rm -rf /opt/minecraft/`/bin/date +%Y-%m-%d`_mc-miuchi.tar.gz

echo minecraft temporary directory Deleted

curl -s $WEBHOOK_URL \
 -X POST \
 -H 'Content-Type:application/json' \
 -d "{\"username\":\"Minecraft Server-Status\",
 \"avatar_url\":\"$AVATAR_URL\",
 \"content\":\"**バックアップが完了しました**\"}"
