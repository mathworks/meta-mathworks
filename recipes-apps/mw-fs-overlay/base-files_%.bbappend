FILESEXTRAPATHS:prepend := "${THISDIR}/files/common/fs-overlay/etc/:"
SRC_URI += " file://fstab"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fstab  ${D}${sysconfdir}/fstab
}

FILES:{PN} += "${sysconfdir}/fstab"
PACKAGE_ARCH = "${MACHINE_ARCH}"
