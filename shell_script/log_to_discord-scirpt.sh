#!/bin/sh

. ./bot_config.txt \

tail -n0 -F /opt/minecraft/logs/latest.log | \
grep --line-buffered -f /opt/minecraft/pattern.txt | \
xargs -I @ curl -s $WEBHOOK_URL \
 -X POST \
 -H 'Content-Type:application/json' \
 -d "{\"username\":\"Minecraft Server-Log\",\
 \"avatar_url\":\"$AVATAR_URL\",\
 \"content\":\"**\`@\`**\"}"
