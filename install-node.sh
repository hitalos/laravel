#!/bin/sh
# Based in this script: https://raw.githubusercontent.com/mhart/alpine-node/base-4.5.0/Dockerfile

export CONFIG_FLAGS="--fully-static" DEL_PKGS="libgcc libstdc++" RM_DIRS=/usr/include

apk add --no-cache curl make gcc g++ python linux-headers paxctl libgcc libstdc++ gnupg
cd /tmp || exit 1
curl -o node-v${NODE_VERSION}.tar.xz -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz
xz -d node-v${NODE_VERSION}.tar.xz
tar -xf node-v${NODE_VERSION}.tar
cd node-v${NODE_VERSION} || exit 1
export GYP_DEFINES="linux_use_gold_flags=0"
./configure --prefix=/usr ${CONFIG_FLAGS}
NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)
make -j${NPROC} -C out mksnapshot BUILDTYPE=Release
paxctl -cm out/Release/mksnapshot
make -j${NPROC}
make install
paxctl -cm /usr/bin/node
cd / || exit 1
if [ -x /usr/bin/npm ]; then
    npm install -g npm@${NPM_VERSION}
    find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf;
fi
apk del curl make gcc g++ python linux-headers paxctl gnupg ${DEL_PKGS}
rm -rf /etc/ssl /node-${VERSION}.tar.gz /SHASUMS256.txt.asc /node-${VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
