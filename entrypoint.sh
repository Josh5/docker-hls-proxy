#!/bin/sh
set -e

print_log() {
    timestamp=$(date +'%Y-%m-%d %H:%M:%S %z')
    pid="$$"
    level="$1"
    shift
    message="$*"
    echo "[${timestamp}] [${pid}] [${level}] ${message}"
}

print_log "info" "external IP:      $(curl -4 -s -m 5 ifconfig.co)"
print_log "info" "node version:     $(node --version)"
print_log "info" "npx version:      $(npx --version)"
print_log "info" "hlsd version:     $(npx hlsd --version)"

print_log "info" "Starting server..."
# https://github.com/warren-bank/HLS-Proxy?tab=readme-ov-file#options
exec npx hlsd \
    -v ${HLS_PROXY_LOG_LEVEL:?} \
    --host ${HLS_PROXY_HOST_IP:?}:${HLS_PROXY_PORT:?} \
    --port ${HLS_PROXY_PORT:?} \
    --prefetch \
    --max-segments 100 \
    --useragent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36 Edg/96.0.1054.62"
