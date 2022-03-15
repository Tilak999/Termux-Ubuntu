#!/bin/sh
clear

echo -e "\x1b[32m\033[1m   #############################################"
echo -e "\x1b[32m     [ Ubuntu Installation Script ]    "
echo -e "\x1b[32m   #############################################"

folder="/sdcard/ubuntu-system"
file="$folder/rootfs-$arch.tar.gz"

# Check if folder not exist 
if [ -d "$folder" ];
then
        first=1
        echo -e "\x1b[32m [ $folder already exist ]" && sleep 0.5
else
        sleep 1 && echo -e " [ Creating $folder ]"
        mkdir -p $folder
fi

# Check if file root-fs exist
if [ -f "$file" ] ; then
    sleep 1
    echo -e "\x1b[32m [ rootfs file exists ! ] " && sleep 1
    echo -e "\x1b[32m [ Deleting file ... ] "
    rm "$file" && sleep 1
    echo -e "\x1b[32m [ Done ! ]"
fi

# Check the device arch and pick correct file
arch=`uname -m`
case "$arch" in
    aarch64|armv8l) arch="arm64" ;;
    armv7l|arm|armhf) arch="armhf" ;;
    *)
        echo -e "\x1b[33m [ Unknown architecture ]"; exit 1 ;;
esac

echo -e "\x1b[33m [ Select Ubuntu version to install ]"
curl -s https://api.github.com/repositories/312190786/git/trees/master\?recursive\=1 | grep -oE "\"path\": \"Ubuntu/[0-9]+.[0-9]+\"" | grep -oE "[0-9]+.[0-9]+"
read version

cd $folder
echo " [ Device architecture is $arch ]"
sleep 1

echo -e "\x1b[33m [ Downloading Ubuntu $version ($arch)... ]"
wget https://raw.githubusercontent.com/mjuned47/Termux-Rootfs/master/Ubuntu/$version/$arch/rootfs-$arch.tar.gz
echo -e "\x1b[33m [ Downloaded ! ]"

echo -e "\x1b[33m [ Now Unpacking File... ]"
tar xzf rootfs-$arch.tar.gz
echo -e "\x1b[32m [ Unpacked ! ]"
rm rootfs-$arch.tar.gz

echo -e "\x1b[33m [ Fixing Internet ... ]"

$folder /bin/su - root -c '
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 1003 aid_graphics
usermod -g 3003 -G 3003,3004 -a _apt
usermod -G 3003 -a root
echo "127.0.0.1 localhost" > /etc/hosts
'

echo -e "\x1b[33m [ Done ! ]"
echo -e "\x1b[32m [ Installation Completed,You can start Ubuntu system ]"
echo -e " [ Ubuntu is installed at $folder ]\e[0m"