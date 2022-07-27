#! /bin/bash

set -e

DISTRO='Debian~bullseye_amd64'

LINK=$(curl https://www.virtualbox.org/wiki/Linux_Downloads | grep ".*${DISTRO}\.deb" | sed -e 's/^.*href="//' -e 's/".*$//')
FILE=${LINK##*/}
VERSION=${FILE#*_}
VERSION=${VERSION%%-*}
DEST="vbox-kernel-module-src-${VERSION}.tar.xz"
[ -f "${DEST}" ] && echo "${DEST} exists" && exit
wget -nc "${LINK}"

rm -f control.tar.xz data.tar.xz debian-binary
rm -fR out
mkdir out

ar x "${FILE}"
tar JxvfC data.tar.xz out
tar JcvfC "${DEST}" out/usr/share/virtualbox/src/vboxhost .

rm -f control.tar.xz data.tar.xz debian-binary
rm -fR out
