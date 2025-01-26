#!/bin/bash

# ======================================================
# OpenWrt Configuration Script
# Purpose: Automatically set up .config for OpenWrt builds
# Usage: Execute this script in your build environment
#        after initializing with "make menuconfig".
# ======================================================

# Stop script on error
set -e

BUILD_ROOT="$(pwd)"
CONFIG_FILE="$BUILD_ROOT/.config"
LOG_FILE="$BUILD_ROOT/configuration.log"

# Initialize the configuration file and log file
initialize_files() {
    touch "$CONFIG_FILE"
    echo "# OpenWRT Configuration Log" > "$LOG_FILE"
}

# Function to append configuration with error handling and logging
append_config() {
    local config="$1"
    if ! echo "$config" >> "$CONFIG_FILE"; then
        echo "Error: Failed to append '$config'" >&2
        echo "[ERROR] $config" >> "$LOG_FILE"
        exit 1
    fi
    echo "[SUCCESS] $config" >> "$LOG_FILE"
}

# Function to append multiple configurations, supports parallelism
append_multiple_configs() {
    local configs=("$@")
    for config in "${configs[@]}"; do
        append_config "$config" &
    done
    wait  # Ensure all background processes finish
}

# Configuration lists
TARGET_CONFIGS=(
    "CONFIG_TARGET_ath79=y"
    "CONFIG_TARGET_ath79_generic=y"
    "CONFIG_TARGET_ath79_generic_DEVICE_elecom_wab-i1750-ps=y"
)

NGINX_FEATURES=(
    "CONFIG_NGINX_HTTP_ACCESS=y"
    "CONFIG_NGINX_HTTP_AUTH_BASIC=y"
    "CONFIG_NGINX_HTTP_AUTOINDEX=y"
    "CONFIG_NGINX_HTTP_BROWSER=y"
    "CONFIG_NGINX_HTTP_CACHE=y"
    "CONFIG_NGINX_HTTP_CHARSET=y"
    "CONFIG_NGINX_HTTP_EMPTY_GIF=y"
    "CONFIG_NGINX_HTTP_FASTCGI=y"
    "CONFIG_NGINX_HTTP_GEO=y"
    "CONFIG_NGINX_HTTP_GZIP=y"
    "CONFIG_NGINX_HTTP_GZIP_STATIC=y"
    "CONFIG_NGINX_HTTP_LIMIT_CONN=y"
    "CONFIG_NGINX_HTTP_LIMIT_REQ=y"
    "CONFIG_NGINX_HTTP_MAP=y"
    "CONFIG_NGINX_HTTP_MEMCACHED=y"
    "CONFIG_NGINX_HTTP_PROXY=y"
    "CONFIG_NGINX_HTTP_REFERER=y"
    "CONFIG_NGINX_HTTP_REWRITE=y"
    "CONFIG_NGINX_HTTP_SCGI=y"
    "CONFIG_NGINX_HTTP_SPLIT_CLIENTS=y"
    "CONFIG_NGINX_HTTP_SSI=y"
    "CONFIG_NGINX_HTTP_UPSTREAM_HASH=y"
    "CONFIG_NGINX_HTTP_UPSTREAM_IP_HASH=y"
    "CONFIG_NGINX_HTTP_UPSTREAM_KEEPALIVE=y"
    "CONFIG_NGINX_HTTP_UPSTREAM_LEAST_CONN=y"
    "CONFIG_NGINX_HTTP_USERID=y"
    "CONFIG_NGINX_HTTP_UWSGI=y"
    "CONFIG_NGINX_HTTP_V2=y"
    "CONFIG_NGINX_PCRE=y"
)

OPENSSL_FEATURES=(
    "CONFIG_OPENSSL_ENGINE=y"
    "CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM=y"
    "CONFIG_OPENSSL_WITH_ASM=y"
    "CONFIG_OPENSSL_WITH_CHACHA_POLY1305=y"
    "CONFIG_OPENSSL_WITH_CMS=y"
    "CONFIG_OPENSSL_WITH_DEPRECATED=y"
    "CONFIG_OPENSSL_WITH_ERROR_MESSAGES=y"
    "CONFIG_OPENSSL_WITH_IDEA=y"
    "CONFIG_OPENSSL_WITH_MDC2=y"
    "CONFIG_OPENSSL_WITH_PSK=y"
    "CONFIG_OPENSSL_WITH_SEED=y"
    "CONFIG_OPENSSL_WITH_SRP=y"
    "CONFIG_OPENSSL_WITH_TLS13=y"
    "CONFIG_OPENSSL_WITH_WHIRLPOOL=y"
)

PACKAGES=(
    "CONFIG_PACKAGE_bash=y"
    "CONFIG_PACKAGE_cgi-io=y"
    "CONFIG_PACKAGE_ip-tiny=y"
    "CONFIG_PACKAGE_kmod-crypto-acompress=m"
    "CONFIG_PACKAGE_kmod-crypto-authenc=m"
    "CONFIG_PACKAGE_kmod-crypto-cbc=m"
    "CONFIG_PACKAGE_kmod-crypto-deflate=m"
    "CONFIG_PACKAGE_kmod-crypto-des=m"
    "CONFIG_PACKAGE_kmod-crypto-echainiv=m"
    "CONFIG_PACKAGE_kmod-crypto-kpp=y"
    "CONFIG_PACKAGE_kmod-crypto-lib-chacha20=y"
    "CONFIG_PACKAGE_kmod-crypto-lib-chacha20poly1305=y"
    "CONFIG_PACKAGE_kmod-crypto-lib-curve25519=y"
    "CONFIG_PACKAGE_kmod-crypto-lib-poly1305=y"
    "CONFIG_PACKAGE_kmod-crypto-md5=m"
    "CONFIG_PACKAGE_kmod-crypto-sha1=m"
    "CONFIG_PACKAGE_kmod-ipsec=m"
    "CONFIG_PACKAGE_kmod-ipsec4=m"
    "CONFIG_PACKAGE_kmod-ipsec6=m"
    "CONFIG_PACKAGE_kmod-iptunnel4=m"
    "CONFIG_PACKAGE_kmod-iptunnel6=m"
    "CONFIG_PACKAGE_kmod-lib-zlib-deflate=m"
    "CONFIG_PACKAGE_kmod-lib-zlib-inflate=m"
    "CONFIG_PACKAGE_kmod-tun=m"
    "CONFIG_PACKAGE_kmod-udptunnel4=y"
    "CONFIG_PACKAGE_kmod-udptunnel6=y"
    "CONFIG_PACKAGE_kmod-wireguard=y"
    "CONFIG_PACKAGE_libatomic=y"
    "CONFIG_PACKAGE_libcap=y"
    "CONFIG_PACKAGE_libcap-ng=m"
    "CONFIG_PACKAGE_liblucihttp=y"
    "CONFIG_PACKAGE_liblucihttp-ucode=y"
    "CONFIG_PACKAGE_liblz4=m"
    "CONFIG_PACKAGE_liblzo=m"
    "CONFIG_PACKAGE_libncurses=y"
    "CONFIG_PACKAGE_libopenssl=y"
    "CONFIG_PACKAGE_libpcre2=y"
    "CONFIG_PACKAGE_libpthread=y"
    "CONFIG_PACKAGE_libreadline=y"
    "CONFIG_PACKAGE_librt=y"
    "CONFIG_PACKAGE_libstdcpp=y"
    "CONFIG_PACKAGE_libuuid=y"
    "CONFIG_PACKAGE_libzip-openssl=m"
    "CONFIG_PACKAGE_libzstd=m"
)

# Main Execution
initialize_files
append_multiple_configs "${TARGET_CONFIGS[@]}"
append_multiple_configs "${NGINX_FEATURES[@]}"
append_multiple_configs "${OPENSSL_FEATURES[@]}"
append_multiple_configs "${PACKAGES[@]}"

# Final Message
echo "Configuration appended successfully. Log file saved to $LOG_FILE."
