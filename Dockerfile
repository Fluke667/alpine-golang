FROM fluke667/alpine

RUN apk update && apk add --no-cache \  
     ca-certificates bash musl musl-dev libc6-compat openssl wget binutils isl libatomic \
     mpfr3 mpc1 pkgconf dpkg git build-base python python-dev python3 python3-dev
            
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN cd /tmp && wget -O go.tgz https://dl.google.com/go/go$GOLANG_VERSION.linux-amd64.tar.gz && \
    tar -xzvf go.tgz && rm go.tgz && cd go && \
    mkdir -p "$GOPATH" "$GOSRC" "$GOBIN" "$GOLIB" "$GOPKG" "$GOTMP" "$GOCACHE" "$GOTMPDIR" "$GOMODIR" "$GOVENDOR" && \
    chmod -R 777 "$GOPATH" && \
    cp -r -f bin /go && cp -r -f lib /go && cp -r -f src /go && cp -r -f pkg /go && \
    go get -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
    go get -v git.torproject.org/pluggable-transports/meek.git/meek-server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/broker && \
    #go get -v github.com/keroserene/go-webrtc && cd /go/src/github.com/keroserene/go-webrtc && \
    #cd /go/bin && mv server snow-server && mv broker snow-broker && \
    #cd /go/src && git clone https://github.com/keroserene/snowflake.git && \
    cd /go/src/snowflake/broker && go get -d -v && go build -v -o /go/bin/snow-broker && \
    cd /go/src/snowflake/proxy-go && go get -d -v && go build -v -o /go/bin/snow-proxy && \
    
    apk del build-deps
    

    
WORKDIR $GOPATH
