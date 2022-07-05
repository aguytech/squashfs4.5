#!/bin/sh

! hash apt 2>/dev/null && echo "This installation is for Ubuntu OS" && exit 1

echo "> Get package from sourceforge"
echo
file=squashfs-tools-4.5.1.tar.gz
if ! [ -f "${file}" ]; then
	curl -L -o ${file} https://sourceforge.net/projects/squashfs/files/squashfs/squashfs4.5.1/${file}/download
	grep -q '^<html' ${file} && { echo; echo "Unable to downloads file: ${file}"; exit 1; }
fi
tar xzf ${file}
path=$( dirname $( readlink -f $0 ) )/squashfs-tools-4.5.1/squashfs-tools
cd ${path} || { echo; echo "Unable find path ${path}"; exit 1; }

echo "> installs required packages"
echo
sudo apt install -y build-essential liblzma-dev liblzo2-dev zlib1g-dev help2man || { echo; echo "Unable to continue without packages installed"; exit 1; }

echo
echo "> make"
make || exit 1

echo
echo "> make install"
sudo make install || exit 1

echo
echo "> Installation succeded"

