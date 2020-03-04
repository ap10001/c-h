FROM heroku/heroku:18
LABEL maintainer 'xxx <xxx@xxx.com>'

RUN set -ex && \
    VERSION=$(curl --silent 'https://api.github.com/repos/jpillora/chisel/releases/latest' | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo "Got latest version = ${VERSION}" && \
    curl -sSL https://github.com/jpillora/chisel/releases/download/${VERSION}/chisel_linux_amd64.gz | gzip -d - > /bin/chisel && \
    chmod +x /bin/chisel && \
    useradd -m heroku
USER heroku
EXPOSE 5000
CMD chisel server --auth $CHISEL_AUTH --socks5 --reverse
