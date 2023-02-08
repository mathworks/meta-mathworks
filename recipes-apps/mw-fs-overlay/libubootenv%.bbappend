FILESEXTRAPATHS:prepend := "${THISDIR}/files/common/fs-overlay/etc/:"

SRC_URI += " file://fw_env.config"

do_install:append() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config

}

PACKAGE_ARCH = "${MACHINE_ARCH}"
