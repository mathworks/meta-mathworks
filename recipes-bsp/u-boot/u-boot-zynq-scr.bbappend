FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " file://boot.cmd.mw.initrd"

BOOTMODE = "mw"
BOOTFILE_EXT = ".initrd"


PACKAGE_ARCH = "${MACHINE_ARCH}"
