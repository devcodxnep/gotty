
FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl tar \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/gotty /usr/local/bin \
    && curl -fL https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz -o /tmp/gotty.tar.gz \
    && tar -xzf /tmp/gotty.tar.gz -C /tmp/gotty \
    && GOTTY_BIN="$(find /tmp/gotty -type f -name 'gotty' | head -n 1)" \
    && test -n "$GOTTY_BIN" \
    && install -m 755 "$GOTTY_BIN" /usr/local/bin/gotty \
    && rm -rf /tmp/gotty /tmp/gotty.tar.gz

ENV PORT=10000

EXPOSE 10000

CMD ["sh", "-c", "exec /usr/local/bin/gotty --address 0.0.0.0 --port \"$PORT\" --random-url top"]
