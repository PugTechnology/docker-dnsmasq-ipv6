# Dockerfile
FROM alpine:latest

# install dnsmasq
RUN apk add --no-cache dnsmasq

# copy your IPv6-only config in
COPY dnsmasq.conf /etc/dnsmasq.conf

# expose DNS ports
EXPOSE 53/udp 53/tcp

# run in foreground
ENTRYPOINT ["dnsmasq", "-k", "--conf-file=/etc/dnsmasq.conf"]
