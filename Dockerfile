FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add py3-pip py3-beautifulsoup4
ENTRYPOINT ["python3.8"]
