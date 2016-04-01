# BananaPi-Archlinux
Some work about BananaPi and Archlinux

Follow these steps :

1- Compile u-boot (http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot) or get the compiled one here.

2- Create the boot.scr file too (http://linux-sunxi.org/Mainline_U-Boot#Compile_U-Boot) or get it here. 

3- dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8

4- Compile zImage and dtb file from Mainline Kernel http://linux-sunxi.org/Mainline_Kernel_Howto or get the compiled ones here. 

5- Install Arch following the same process here but use the previous files https://archlinuxarm.org/platforms/armv7/allwinner/pcduino3

