FROM ubuntu:latest as builder

# RUN echo $()

RUN set -ex && \
    apt-get update && \
    apt-get install curl -y && \
    curl -L -o /tmp/go.sh https://install.direct/go.sh && \
    chmod +x /tmp/go.sh && \
    /tmp/go.sh

FROM alpine:latest

LABEL maintainer "Darian Raymond <admin@v2ray.com>"

COPY --from=builder /usr/bin/v2ray/v2ray /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/v2ctl /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geoip.dat /usr/bin/v2ray/
COPY --from=builder /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/
COPY server_config.json /etc/v2ray/config.json

RUN set -ex && \
    sed -i "s/8888/$PORT/g" /etc/v2ray/config.json && \
    sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json && \
    cat /etc/v2ray/config.json && \
    apk --no-cache add ca-certificates && \
    mkdir /var/log/v2ray/ &&\
    chmod +x /usr/bin/v2ray/v2ctl && \
    chmod +x /usr/bin/v2ray/v2ray

ENV PATH /usr/bin/v2ray:$PATH

CMD ["/usr/bin/v2ray/v2ray", "-config=/etc/v2ray/config.json"]
