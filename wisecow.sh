#!/usr/bin/env bash

SRVPORT=4499
RSPFILE-/tmp/wisecow

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}
handleRequest() {
     HTTP_CODE=200
     get_api
     fortune | cowsay >/tmp/f.txt
     CONTENT=$(cat /tmp/f.txt)
     LENGTH=$(echo "$CONTENT" |wc -c)
     echo -e "HTTP/1.1 $HTTP_CODE OK\r\nContent-Length: $LENGTH\r\nContent-Type: text/html\r\n\r\n<pre>$CONTENT</pre>"
}
hancle() {
   while true; do
       cat $RSPFILE | handleRequest | nc -l -p $SRVPFILE 2>&1
    done
}
handle
