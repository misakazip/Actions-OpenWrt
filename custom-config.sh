#!/bin/bash

# ======================================================
# OpenWrt Configuration Script
# Purpose: Automatically set up .config for OpenWrt builds
# Usage: Execute this script in your build environment
#        after initializing with "make menuconfig".
# ======================================================

# Stop script on error
set -e

# Define build root directory (adjust if necessary)
BUILD_ROOT=${BUILD_ROOT:-"./"}

# Target platform settings
echo "# Adding target platform settings..."
echo 'CONFIG_TARGET_ath79=y' >> $BUILD_ROOT/.config
echo 'CONFIG_TARGET_ath79_generic=y' >> $BUILD_ROOT/.config
echo 'CONFIG_TARGET_ath79_generic_DEVICE_elecom_wab-i1750-ps=y' >> $BUILD_ROOT/.config

# Language settings
echo "# Adding language settings..."
echo 'CONFIG_LUCI_LANG_ja=y' >> $BUILD_ROOT/.config

# NGINX settings
echo "# Adding NGINX settings..."
for setting in \
    CONFIG_NGINX_HTTP_ACCESS \
    CONFIG_NGINX_HTTP_AUTH_BASIC \
    CONFIG_NGINX_HTTP_AUTOINDEX \
    CONFIG_NGINX_HTTP_BROWSER \
    CONFIG_NGINX_HTTP_CACHE \
    CONFIG_NGINX_HTTP_CHARSET \
    CONFIG_NGINX_HTTP_EMPTY_GIF \
    CONFIG_NGINX_HTTP_FASTCGI \
    CONFIG_NGINX_HTTP_GEO \
    CONFIG_NGINX_HTTP_GZIP \
    CONFIG_NGINX_HTTP_GZIP_STATIC \
    CONFIG_NGINX_HTTP_LIMIT_CONN \
    CONFIG_NGINX_HTTP_LIMIT_REQ \
    CONFIG_NGINX_HTTP_MAP \
    CONFIG_NGINX_HTTP_MEMCACHED \
    CONFIG_NGINX_HTTP_PROXY \
    CONFIG_NGINX_HTTP_REFERER \
    CONFIG_NGINX_HTTP_REWRITE \
    CONFIG_NGINX_HTTP_SCGI \
    CONFIG_NGINX_HTTP_SPLIT_CLIENTS \
    CONFIG_NGINX_HTTP_SSI \
    CONFIG_NGINX_HTTP_UPSTREAM_HASH \
    CONFIG_NGINX_HTTP_UPSTREAM_IP_HASH \
    CONFIG_NGINX_HTTP_UPSTREAM_KEEPALIVE \
    CONFIG_NGINX_HTTP_UPSTREAM_LEAST_CONN \
    CONFIG_NGINX_HTTP_USERID \
    CONFIG_NGINX_HTTP_UWSGI \
    CONFIG_NGINX_HTTP_V2 \
    CONFIG_NGINX_PCRE; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# OpenSSL settings
echo "# Adding OpenSSL settings..."
for setting in \
    CONFIG_OPENSSL_ENGINE \
    CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM \
    CONFIG_OPENSSL_WITH_ASM \
    CONFIG_OPENSSL_WITH_CHACHA_POLY1305 \
    CONFIG_OPENSSL_WITH_CMS \
    CONFIG_OPENSSL_WITH_DEPRECATED \
    CONFIG_OPENSSL_WITH_ERROR_MESSAGES \
    CONFIG_OPENSSL_WITH_IDEA \
    CONFIG_OPENSSL_WITH_MDC2 \
    CONFIG_OPENSSL_WITH_PSK \
    CONFIG_OPENSSL_WITH_SEED \
    CONFIG_OPENSSL_WITH_SRP \
    CONFIG_OPENSSL_WITH_TLS13 \
    CONFIG_OPENSSL_WITH_WHIRLPOOL; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# OpenVPN settings
echo "# Adding OpenVPN settings..."
for setting in \
    CONFIG_OPENVPN_openssl_ENABLE_FRAGMENT \
    CONFIG_OPENVPN_openssl_ENABLE_LZ4 \
    CONFIG_OPENVPN_openssl_ENABLE_LZO \
    CONFIG_OPENVPN_openssl_ENABLE_PORT_SHARE \
    CONFIG_OPENVPN_openssl_ENABLE_SMALL; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# Package settings
echo "# Adding package settings..."
for setting in \
    CONFIG_PACKAGE_cgi-io \
    CONFIG_PACKAGE_libatomic \
    CONFIG_PACKAGE_libcap \
    CONFIG_PACKAGE_liblucihttp \
    CONFIG_PACKAGE_liblucihttp-ucode \
    CONFIG_PACKAGE_libopenssl \
    CONFIG_PACKAGE_libpcre2 \
    CONFIG_PACKAGE_libpthread \
    CONFIG_PACKAGE_librt \
    CONFIG_PACKAGE_libstdcpp \
    CONFIG_PACKAGE_libuuid; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# LuCI settings
echo "# Adding LuCI settings..."
for setting in \
    CONFIG_PACKAGE_luci-app-firewall \
    CONFIG_PACKAGE_luci-app-package-manager \
    CONFIG_PACKAGE_luci-base \
    CONFIG_PACKAGE_luci-i18n-base-ja \
    CONFIG_PACKAGE_luci-i18n-firewall-ja \
    CONFIG_PACKAGE_luci-i18n-package-manager-ja \
    CONFIG_PACKAGE_luci-mod-admin-full \
    CONFIG_PACKAGE_luci-mod-network \
    CONFIG_PACKAGE_luci-mod-status \
    CONFIG_PACKAGE_luci-mod-system \
    CONFIG_PACKAGE_luci-theme-bootstrap; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# Additional packages
echo "# Adding additional packages..."
for setting in \
    CONFIG_PACKAGE_luci-app-wol \
    CONFIG_PACKAGE_luci-app-aria2 \
    CONFIG_PACKAGE_ariang \
    CONFIG_PACKAGE_luci-app-samba4 \
    CONFIG_PACKAGE_luci-app-upnp; do
    echo "$setting=y" >> $BUILD_ROOT/.config
done

# Final message
echo "Configuration complete. You can now proceed with the build."
