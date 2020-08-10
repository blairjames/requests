FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add --no-cache \
    python3 py3-pip
RUN pip install bs4 && pip install requests
ENTRYPOINT ["python3.8"]

#FROM scratch
#COPY --from=0 / /

