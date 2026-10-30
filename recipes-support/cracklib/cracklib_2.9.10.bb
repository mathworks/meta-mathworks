# CrackLib BitBake recipe

SUMMARY = "CrackLib is a library to enforce strong passwords"
DESCRIPTION = "CrackLib is a library that can be used to enforce strong passwords by preventing users from choosing passwords that are too simple."
HOMEPAGE = "https://github.com/cracklib/cracklib"
LICENSE = "LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=e3eda01d9815f8d24aae2dbd89b68b06"

SRC_URI = "https://github.com/cracklib/cracklib/releases/download/v${PV}/cracklib-${PV}.tar.gz"
SRC_URI[md5sum] = "29e16b33cf4b2ed9c59b898594b9c399"
SRC_URI[sha256sum] = "6d7726ce2ab9ee35aa46a511f12badb059b3ceb7932c7fe64806d265b898aa63"

# Replace with the actual version you are using
PV = "2.9.10"

DEPENDS = "autoconf automake libtool"

inherit autotools gettext

# Specify any extra configuration options
EXTRA_OECONF = "--disable-static"

do_install:append() {
    # Install additional files if necessary
    #install -d ${D}${datadir}/cracklib
    #install -m 0644 ${S}/cracklib-words ${D}${datadir}/cracklib/
}

#FILES_${PN} += "${datadir}/cracklib"

# If there are any post-installation tasks
# pkg_postinst_${PN}() {
#     # Post-install script commands
# }

# If there are any post-removal tasks
# pkg_postrm_${PN}() {
#     # Post-removal script commands
# }
