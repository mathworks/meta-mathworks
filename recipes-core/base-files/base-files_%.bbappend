# Mount the FAT32 boot partition to /mnt
dirs755 += "/mnt"
PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install_append() {
    sed -i '/mmcblk0p1/d' ${D}${sysconfdir}/fstab 
    cat >> ${D}${sysconfdir}/fstab <<EOF
/dev/mmcblk0p1       /mnt          auto      defaults,async           0  0
EOF
}

