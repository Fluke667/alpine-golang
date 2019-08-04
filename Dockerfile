FROM golang:1.12-alpine3.10

ENV CGO_ENABLED=1 \
GOOS=linux \
GOARCH=amd64 \
OROOT=/usr/lib/go \
GOPATH=/go \    
GO111MODULE=auto \     
PATH=/go/bin:$PATH

RUN apk --no-cache add git build-base

RUN mkdir -p /go /go/bin /go/src && \
    go get -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
    go get -v git.torproject.org/pluggable-transports/meek.git/meek-server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/broker

