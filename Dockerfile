
FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl tar

RUN curl -fL \
    https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    -o /tmp/gotty.tar.gz \
    && tar -xzf /tmp/gotty.tar.gz -C /usr/local/bin gotty \
    && chmod +x /usr/local/bin/gotty \
    && rm /tmp/gotty.tar.gz

ENV PORT=10000

EXPOSE 10000

CMD ["sh", "-c", "exec gotty --address 0.0.0.0 --port \"$PORT\" --random-url top"]
