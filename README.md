# BananaPi-Archlinux
Some work about BananaPi and Archlinux

Follow these steps :

1- Compile u-boot (http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot) or get the compiled one here (u-boot-sunxi-with-spl.bin).

a- git clone git://git.denx.de/u-boot.git
b- make -j<Number of CPUs> CROSS_COMPILE=arm-none-eabi- Bananapi_defconfig
c- make -j<Number of CPUs> CROSS_COMPILE=arm-none-eabi-

2- Create the boot.scr file or get it here (boot.scr). 

a - Create the boot.cmd file with following content:

fatload mmc 0 0x46000000 zImage
fatload mmc 0 0x49000000 sun7i-a20-bananapi.dtb
setenv bootargs console=ttyS0,115200 [earlyprintk] root=/dev/mmcblk0p2 rw rootwait panic=10 ${extra}
bootz 0x46000000 - 0x49000000

b- generate the boot.scr file:
mkimage -C none -A arm -T script -d boot.cmd boot.scr

3- Compile zImage and dtb file from Mainline Kernel http://linux-sunxi.org/Mainline_Kernel_Howto or get the compiled ones here (Kernel 4.4.6). 

a- git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
b- Get the file bananapiv6_defconfig and put it in git folder (linux/arch/arm/configs/)
c- make -j<Number of CPUs> ARCH=arm CROSS_COMPILE=arm-none-eabi- bananapiv6_defconfig
d- make -j<Number of CPUs> ARCH=arm CROSS_COMPILE=arm-none-eabi- zImage dtbs
e- Get the zImage file from linux/arch/arm/boot/
f- Get the sun7i-a20-bananapi.dtb file from linux/arch/arm/boot/dtb/

Warning, starting from Kernel 4.5 some changes have been made on stmmac driver. If problem get the 4.4.6 kernel.

5- Install Arch

a- Get a 4GB SDcard at least
b- Create two partitions with fdisk. 100M for the first, the rest of SD for the second. We will consider the card is mmcblk0.
c- mkfs.vfat /dev/mmcblk0p1
d- mkfs.ext4 /dev/mmcblk0p2
e- mount /dev/mmcblk0p2 /mnt
f- mkdir /mnt/boot
g- mount /dev/mmcblk0p1 /mnt/boot
h- wget http://archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz
i- bsdtar -xpf ArchLinuxARM-armv7-latest.tar.gz -C /mnt && sync
j- dd dd if=u-boot-sunxi-with-spl.bin of=/dev/mmcblk0 bs=1024 seek=8
k- cp boot.scr /mnt/boot
l- cp zImage /mnt/boot
m- cp sun7i-a20-bananapi.dtb /mnt/boot

6- Start the Bananapi. It should work :)

Root password is root. Alarm password is alarm (default from Arch ARM).