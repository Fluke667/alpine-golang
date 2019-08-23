FROM fluke667/alpine

RUN apk add --no-cache ca-certificates
            
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN apk update && apk add --no-cache --virtual build-deps \      
    git build-base python python-dev python3 python3-dev bash gcc musl-dev openssl go && \
        
    wget -O go.tgz "https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz"; \
    tar -C /usr/local -xzf go.tgz; \
	  rm go.tgz; \  
	  \     
	  cd /usr/local/go/src; \    
	 ./make.bash; \   
	  \
    rm -rf \
		/usr/local/go/pkg/bootstrap \
    /usr/local/go/pkg/obj \
	  ; \

    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
    
RUN go get -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy && \
    go get -v git.torproject.org/pluggable-transports/meek.git/meek-server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/server && \
    go get -v git.torproject.org/pluggable-transports/snowflake.git/broker && \
    #go get -v github.com/keroserene/go-webrtc && cd /go/src/github.com/keroserene/go-webrtc && \
    #cd /go/bin && mv server snow-server && mv broker snow-broker && \
    #cd /go/src && git clone https://github.com/keroserene/snowflake.git && \
    cd /go/src/snowflake/broker && go get -d -v && go build -v -o /go/bin/snow-broker && \
    cd /go/src/snowflake/proxy-go && go get -d -v && go build -v -o /go/bin/snow-proxy && \
    
    apk del build-deps && \
    
    ls /usr/local/go && \
    ls /usr/lib/go
    
WORKDIR $GOPATH
