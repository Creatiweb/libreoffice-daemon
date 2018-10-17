#!/bin/bash

_term() { 
  echo "Caught SIGTERM signal!" 
  kill -TERM "$child" 2>/dev/null
}

trap _term TERM INT

/usr/bin/libreoffice --nologo --norestore --invisible --headless --accept='socket,host=0,port=8100,tcpNoDelay=1;urp;' &

child=$! 
wait "$child"
