FROM golang:1.12-alpine3.10

ENV CGO_ENABLED=0 \
GOOS=linux \
GOARCH=amd64 \
GOROOT=/usr/lib/go \
GOPATH=/go \    
GO111MODULE=auto \     
PATH=/go/bin:$PATH

RUN apk update && apk add --no-cache --virtual build-deps \
git build-base python python-dev python3 python3-dev && \


    mkdir -p "$GOPATH/src" "$GOPATH/bin" "$GOROOT" && chmod -R 777 "$GOPATH" && \
    
    go get -u github.com/golang/dep/cmd/dep && \
    #
    go get -u git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
    go get -u git.torproject.org/pluggable-transports/meek.git/meek-server && \
    go get -u git.torproject.org/pluggable-transports/snowflake.git/server && \
    go get -u git.torproject.org/pluggable-transports/snowflake.git/broker && \
    #go get -v github.com/keroserene/go-webrtc && cd /go/src/github.com/keroserene/go-webrtc && \
    #cd /go/bin && mv server snow-server && mv broker snow-broker && \
    #cd /go/src && git clone https://github.com/keroserene/snowflake.git && \
    go get -v github.com/keroserene/go-webrtc && cd /go/src/github.com/keroserene/go-webrtc && \
    cd /go/bin && mv server snow-server && mv broker snow-broker && \
    cd /go/src && git clone https://github.com/keroserene/snowflake.git && \
    cd /go/src/snowflake/broker && go get -d -v && go build -v -o /go/bin/snow-broker && \
    cd /go/src/snowflake/proxy-go && go get -d -v && go build -v -o /go/bin/snow-proxy && \
    

apk del build-deps
