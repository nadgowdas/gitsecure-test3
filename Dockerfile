FROM golang:1.11
RUN apt-get update --fix-missing && apt-get install -y --fix-missing libnghttp2-14=1.36.0-2   
WORKDIR /go/src/github.com/multi-stage3
RUN go get -d -v golang.org/x/net/html  
COPY app.go .


FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add --update py-pip   python2.72.7.16-2+deb10u1  openssl1.1.1d-0+deb10u1  curl7.64.0-4+deb10u1  e2fsprogs1.44.5-1+deb10u3  
RUN pip install   django==1.2 certifi==2019.3.9 chardet==3.0.4

WORKDIR /root/
COPY --from=0 /go/src/github.com/multi-stage3/app .
CMD ["./app"]  
