#!/bin/sh

if [ ! -f /root/oauth/oauth.key ]; then
    trap 'exit 0' TERM INT
    while :
    do
        sleep 2
    /bin/true
    done
else
    trap 'kill -TERM $PIDU;kill -TERM $PIDD' TERM INT
    PARAMS=''
    if [ "$REMOVE" = "1" || "$REMOVE" = "True" || "$REMOVE" = "true" || "$REMOVE" = "TRUE" ]; then
        PARAMS="-r"
    fi
    if [ "$ONESHOT" = "1" || "$ONESHOT" = "True" || "$ONESHOT" = "true" || "$ONESHOT" = "TRUE" ]; then
        PARAMS="$PARAMS -o"
    fi
    if [ "$UPLOADER_ID" ]; then
        PARAMS="$PARAMS --uploader_id $UPLOADER_ID"
    fi
    if [ "$DOWNLOAD" ]; then
        google-music-download -d /media/library/download -a /root/oauth/oauth.key &
        PIDD=$!
    fi
    if [ "$UPLOAD" ]; then
        google-music-upload -d /media/library -a /root/oauth/oauth.key $PARAMS &
        PIDU=$!
    fi
    if [ "$DOWNLOAD" ]; then
        wait $PIDD
        wait $PIDD
    fi
    if [ "$UPLOAD" ]; then
        wait $PIDU
        wait $PIDU
    fi

    EXIT_STATUS=$?
fi
