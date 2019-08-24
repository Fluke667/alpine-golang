#!/bin/sh

    go get -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy &
    go get -v git.torproject.org/pluggable-transports/meek.git/meek-server &
    go get -v git.torproject.org/pluggable-transports/snowflake.git/server &
    go get -v git.torproject.org/pluggable-transports/snowflake.git/broker &
    #go get -v github.com/keroserene/go-webrtc && cd /go/src/github.com/keroserene/go-webrtc &
    #cd /go/bin && mv server snow-server && mv broker snow-broker &
    #cd /go/src && git clone https://github.com/keroserene/snowflake.git &
    cd /go/src/snowflake/broker && go get -d -v && go build -v -o /go/bin/snow-broker &
    cd /go/src/snowflake/proxy-go && go get -d -v && go build -v -o /go/bin/snow-proxy
