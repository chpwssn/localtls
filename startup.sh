#!/bin/bash
BASEFILE="localtls.nginx.conf"
DESTFILE="/etc/nginx/conf.d/default.conf"
TEMPONE="/tmp/file1"
TEMPTWO="/tmp/file2"

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

# Preload TEMPONE with base file
cat $BASEFILE > $TEMPONE

if [ "$CORS" == "" ]
then
    # No CORS defined, remove that line
    cat $TEMPONE | sed s/^.*{{CORS}}.*$// > $TEMPTWO
else
    # CORS defined, set it
    cat $TEMPONE | sed s/{{CORS}}/$CORS/ > $TEMPTWO
fi

mv $TEMPTWO $TEMPONE

cat "$TEMPONE" | sed s/{{DESTHOST}}/$DESTHOST/ | sed s/{{DESTPORT}}/$DESTPORT/ > $DESTFILE

service nginx restart

while true
do
    echo "Running..."
    sleep 10
done

