FROM alpine:latest

RUN \
  apk update --no-cache \
  && apk add \
    py3-pip \
    py3-beautifulsoup4 \
    py3-requests \
    util-linux-misc \
  && apk upgrade 

ENTRYPOINT ["/usr/bin/python"]
