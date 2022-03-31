#!/bin/sh

# screenの名前
SCREEN_NAME="minecraft" \
# 設定ファイル読み込み
. ./bot_config.txt

if [ -n "$(screen -list | grep -o "${SCREEN_NAME}")" ]; then
    # 停止開始
    echo [date '+%F %T'] 'server stop script start'
    # サーバー内にアナウンス
    screen -S $SCREEN_NAME -X stuff 'say 30秒後にサーバーを停止します。\015'
    sleep 25
    screen -S $SCREEN_NAME -X stuff 'say サーバー停止まで残り5秒・・・\015'
    sleep 1
    screen -S $SCREEN_NAME -X stuff 'say サーバー停止まで残り4秒・・・\015'
    sleep 1
    screen -S $SCREEN_NAME -X stuff 'say サーバー停止まで残り3秒・・・\015'
    sleep 1
    screen -S $SCREEN_NAME -X stuff 'say サーバー停止まで残り2秒・・・\015'
    sleep 1
    screen -S $SCREEN_NAME -X stuff 'say サーバー停止まで残り1秒・・・\015'
    sleep 1
    screen -p 0 -S $SCREEN_NAME -X stuff 'kick @a サーバーを停止しました。\015'
   
    # Discord内にアナウンスをPost
    curl -s $WEBHOOK_URL \
    -X POST \
    -H 'Content-Type:application/json' \
    -d "{\"username\":\"Minecraft Server-Status\",
    \"avatar_url\":\"$AVATAR_URL\",
    \"content\":\"**サーバーを停止しました**\"}"

    # セーブコマンド発行
    screen -S $SCREEN_NAME -X stuff 'save-all\015'
    sleep 5
    ./backup.sh
    # 停止コマンド発行
    screen -S $SCREEN_NAME -X stuff 'stop\015'
    #停止実行待機
    sleep 30
else
    echo [date '+%F %T']  'server is not runnning'
fi
