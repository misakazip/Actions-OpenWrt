# 为OpenClash添加外部文件
#mkdir -p files/etc/openclash/core
#
#CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz"
#CLASH_TUN_URL=$(curl -fsSL https://api.github.com/repos/vernesong/OpenClash/contents/master/premium | grep download_url | grep $1 | awk -F '"' '{print $4}')
#CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz"
#GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
#GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
#
#wget -qO- $CLASH_DEV_URL | tar xOvz > files/etc/openclash/core/clash
#wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
#wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
#wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
#wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
#
#chmod +x files/etc/openclash/core/clash*