FROM heroku/heroku:18
LABEL maintainer 'xxx <xxx@xxx.com>'

RUN set -ex && \
    mkdir -p /usr/local/brook/bin && \
    cd /usr/local/brook/bin && \
    VERSION=$(curl --silent 'https://api.github.com/repos/txthinking/brook/releases/latest' | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo "Got latest version = ${VERSION}" && \
    curl -Lo brook https://github.com/txthinking/brook/releases/download/${VERSION}/brook && \
    chmod +x brook
RUN useradd -m heroku
USER heroku
EXPOSE 5000

# ENV PATH /usr/bin/v2ray:$PATH
# COPY --from=download /usr/bin/v2ray/v2ray /usr/bin/v2ray/
# COPY --from=download /usr/bin/v2ray/v2ctl /usr/bin/v2ray/
# COPY --from=download /usr/bin/v2ray/geoip.dat /usr/bin/v2ray/
# COPY --from=download /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/
# COPY server_config.json /etc/v2ray/config.json

#ADD entrypoint.sh .

# RUN set -ex && \
#     mkdir /var/log/v2ray/ &&\
#     chmod +x /usr/bin/v2ray/v2ctl && \
#     chmod +x /usr/bin/v2ray/v2ray

# CMD ["/bin/sh", "/entrypoint.sh"]
CMD /usr/local/brook/bin/brook server -l :5000 -p Ff-1028
