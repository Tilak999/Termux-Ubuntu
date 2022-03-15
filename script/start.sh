#!/bin/sh
echo -e ""
echo -e "\x1b[32m\033[1m#################################"
echo -e "\x1b[32m#      Script by Pro-L!nux      #"
echo -e "\x1b[32m#################################"
export PATH=/sbin:/usr/bin:/usr/sbin:/system/bin:/system/xbin:$PATH
export USER=root
export HOME=/root
export LANGUAGE=C
export LANG=C
folder=/sdcard/ubuntu-system
echo -e "\x1b[33m [ Mounting system folders ]"
echo "   [ Mounting /dev ... ]"
mount --bind /dev $folder/dev
echo "   [ Mounting /sys ... ]"
mount --bind /sys $folder/sys
echo "   [ Mounting /proc ... ]"
mount --bind /proc $folder/proc
echo "   [ Mounting /dev/pts ... ]"
mount --bind /dev/pts $folder/dev/pts
echo "   [ Mounting /sdcard ... ]"
mount --bind /sdcard $folder/sdcard
echo -e "\x1b[32m [ Mounting Done ! ]"

echo -e "\x1b[32m [ Chrooting ... ]\e[0m"
chroot $folder /bin/su - root

echo -e "\033[1m\x1b[33m [ Unmounting dev/pts ... ]"
umount $folder/dev/pts
echo -e " [ Unmounting /dev ... ]"
umount $folder/dev
echo -e " [ Unmounting /proc ... ]"
umount $folder/proc
echo -e " [ Unmounting sdcard ... ]"
umount $folder/sdcard
echo -e " [ Unmounting /sys ... ]"
umount $folder/sys
echo -e " \x1b[32m[ Unmounted ]\e[0m"
