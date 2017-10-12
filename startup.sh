#!/bin/bash
BASEFILE="localtls.nginx.conf"
DESTFILE="/etc/nginx/conf.d/default.conf"

if [ "$DESTHOST" == "" ]
then
    echo "You must provide the DESTHOST environment variable."
    exit 1
fi

if [ "$DESTPORT" == "" ]
then
    echo "You must provide the DESTPORT environment variable."
    exit 2
fi

cat "$BASEFILE" | sed s/{{DESTHOST}}/$DESTHOST/ | sed s/{{DESTPORT}}/$DESTPORT/ > $DESTFILE

service nginx restart

while true
do
    echo "Running..."
    sleep 10
done

