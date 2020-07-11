FROM golang:alpine as builder
ARG TARGETARCH
ARG TARGETOS


ARG CLOUDFLARED_VERSION=2020.7.1


RUN apk add --update --no-cache \
        bash \
        build-base \
        gcc \
        git \
 && rm -rf /tmp/* /var/cache/apk/*


ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    TARGET_GOOS=${TARGETOS} \
    TARGET_GOARCH=${TARGETARCH}

RUN git clone https://github.com/cloudflare/cloudflared \
              /go/src/github.com/cloudflare/cloudflared
WORKDIR /go/src/github.com/cloudflare/cloudflared

RUN make cloudflared


FROM alpine:latest


ENV TZ="UTC" \
    TUNNEL_METRICS="0.0.0.0:49312" \
    TUNNEL_DNS_ADDRESS="0.0.0.0" \
    TUNNEL_DNS_PORT="5053" \
    TUNNEL_DNS_UPSTREAM="https://1.1.1.1/dns-query,https://1.0.0.1/dns-query"

RUN apk add --update --no-cache \
        bind-tools \
        ca-certificates \
        libressl \
        shadow \
        tzdata \
 && addgroup -g 1000 cloudflared \
 && adduser -u 1000 -G cloudflared -s /sbin/nologin -D cloudflared \
 && rm -rf /tmp/* /var/cache/apk/*


COPY --from=builder /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/cloudflared

RUN cloudflared --version


USER cloudflared

EXPOSE 5053/udp
EXPOSE 49312/tcp

ENTRYPOINT [ "/usr/local/bin/cloudflared" ]
CMD [ "proxy-dns" ]


HEALTHCHECK --interval=30s --timeout=20s --start-period=10s \
        CMD dig +short @127.0.0.1 -p 5053 cloudflare.com A || exit 1
