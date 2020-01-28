FROM golang:1.11
RUN apt-get update --fix-missing && apt-get install -y --fix-missing libnghttp2-14=1.36.0-2
WORKDIR /go/src/github.com/multi-stage3
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
#GITSECURE REMEDIATION 
RUN  pip install mistune>=0.8.1  Jinja2>=2.10.1 \ 
     SQLAlchemy>=1.3.0  Werkzeug>=0.15.3 \ 
     nltk>=3.4.5  Pillow>=6.2.0 \ 
     



FROM alpine:latest  
RUN apk --no-cache add ca-certificates
RUN apk add --update py-pip
RUN pip install django==1.2 certifi==2019.3.9 chardet==3.0.4 idna==2.8

WORKDIR /root/
COPY --from=0 /go/src/github.com/multi-stage3/app .
CMD ["./app"]  
