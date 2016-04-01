# BananaPi-Archlinux
How to install Archlinux on BananaPi-M1 with last kernel.
Didn't try it on other models...

Follow these steps :

1. Compile u-boot (http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot) or get the compiled one here (u-boot-sunxi-with-spl.bin).
	* git clone git://git.denx.de/u-boot.git
	* make -j<Number of CPUs> CROSS_COMPILE=arm-none-eabi- Bananapi_defconfig
	* make -j<Number of CPUs> CROSS_COMPILE=arm-none-eabi-

2. Create the boot.scr file or get it here (boot.scr). 

	* Get the boot.cmd file. Or directly the boot.scr and skip b- step.
	* Generate the boot.scr file: mkimage -C none -A arm -T script -d boot.cmd boot.scr

3. Compile zImage and dtb file from Mainline Kernel http://linux-sunxi.org/Mainline_Kernel_Howto or get the compiled ones here (Kernel 4.4.6). 

	* git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	* Get the file bananapi_defconfig and put it in git folder (linux/arch/arm/configs/)
	* make -j<Number of CPUs> ARCH=arm CROSS_COMPILE=arm-none-eabi- bananapi_defconfig
	* make -j<Number of CPUs> ARCH=arm CROSS_COMPILE=arm-none-eabi- zImage dtbs
	* Get the zImage file from linux/arch/arm/boot/
	* Get the sun7i-a20-bananapi.dtb file from linux/arch/arm/boot/dtb/

Warning, starting from Kernel 4.5 some changes have been made on stmmac driver. If problem get the 4.4.6 kernel.

5. Install Arch

	* Get a 4GB SDcard at least
	* Create two partitions with fdisk. 100M for the first, the rest of SD for the second. We will consider the card is mmcblk0.
	* mkfs.vfat /dev/mmcblk0p1
	* mkfs.ext4 /dev/mmcblk0p2
	* mount /dev/mmcblk0p2 /mnt
	* mkdir /mnt/boot
	* mount /dev/mmcblk0p1 /mnt/boot
	* wget http://archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz
	* bsdtar -xpf ArchLinuxARM-armv7-latest.tar.gz -C /mnt && sync
	* dd dd if=u-boot-sunxi-with-spl.bin of=/dev/mmcblk0 bs=1024 seek=8
	* cp boot.scr /mnt/boot
	* cp zImage /mnt/boot
	* cp sun7i-a20-bananapi.dtb /mnt/boot

6. Start the Bananapi. It should work :)

Root password is root. Alarm password is alarm (default from Arch ARM).

* Licenses:
	* Archlinux: https://wiki.archlinux.org/index.php/Licenses
	* Kernel: https://www.kernel.org/pub/linux/kernel/COPYING
	* u-boot: http://www.denx.de/wiki/U-Boot/Licensing


