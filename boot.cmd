fatload mmc 0 0x46000000 zImage
fatload mmc 0 0x49000000 sun7i-a20-bananapi.dtb
setenv bootargs console=ttyS0,115200 [earlyprintk] root=/dev/mmcblk0p2 rw rootwait panic=10 ${extra}
bootz 0x46000000 - 0x49000000
