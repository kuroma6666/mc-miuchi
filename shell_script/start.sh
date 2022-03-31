#!/bin/sh

# 設定ファイル読み込み
. ./bot_config.txt

# Discord内にアナウンスをPost
curl -s $WEBHOOK_URL \
 -X POST \
 -H 'Content-Type:application/json' \
 -d "{\"username\":\"Minecraft Server-Status\",
 \"avatar_url\":\"$AVATAR_URL\",
 \"content\":\"**サーバーを起動しました**\"}"

# Minecraftサーバ起動
screen -AdmSU minecraft java  -Xms1G -Xmx3G -jar server_1.18.2.jar nogui

