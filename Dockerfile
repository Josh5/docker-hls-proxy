FROM node:20-bookworm-slim

LABEL maintainer="Josh.5 <jsunnex@gmail.com>"

WORKDIR /app

COPY package.json /app/
COPY package-lock.json /app/

RUN \
    echo "**** Install entrypoint dependencies ****" \
        && apt-get update \
        && apt-get install --no-install-recommends -y \
            bash \
            curl \
    && \
    echo "**** Install service dependencies ****" \
        && npm ci \
    && \
    echo "**** Section cleanup ****" \
        && apt-get clean autoclean -y \
        && apt-get autoremove -y \
        && rm -rf \
            /var/lib/apt/lists/* \
    && \
    echo

COPY entrypoint.sh /

ENV HLS_PROXY_LOG_LEVEL=1 \
    HLS_PROXY_PORT=9987

ENTRYPOINT ["/entrypoint.sh"]
CMD []
