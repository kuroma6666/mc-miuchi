#!/bin/sh

#設定ファイル読み込み
. ./bot_config.txt

DIR_BASE=/opt/minecraft
DIR_COPY=media/share_minecraft

# コピー元からコピー先へディレクトリごとコピー
cp -rp $DIR_BASE $DIR_COPY
echo Backup Done

sleep 5

# コピー先へ移動
cd $DIR_COPY

# コピー先ディレクトリを圧縮
tar cfzP `/bin/date +%Y-%m-%d`_mc-miuchi.tar.gz minecraft
echo Compression Done

# コピー先の一時コピーを削除
rm -rf $DIR_COPY_DELETE/minecraft
echo minecraft temporary directory Deleted

# コピー元の圧縮ファイルを削除
cd $DIR_BASE
rm -rf . ./`/bin/date +%Y-%m-%d`_mc-miuchi.tar.gz

sleep 5

# Discord内にアナウンスをPost
curl -s $WEBHOOK_URL \
 -X POST \
 -H 'Content-Type:application/json' \
 -d "{\"username\":\"Minecraft Server-Status\",
 \"avatar_url\":\"$AVATAR_URL\",
 \"content\":\"**バックアップが完了しました**\"}"
