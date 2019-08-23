FROM fluke667/alpine

RUN apk add --no-cache ca-certificates
            
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

RUN apk update && apk add --no-cache --virtual build-deps \      
    git build-base python python-dev python3 python3-dev bash gcc musl-dev openssl go wget binutils isl \
    libatomic mpfr3 mpc1 && \
    
    go env
    
    
WORKDIR $GOPATH
