# mw-refdesign-dtb
DESCRIPTION = "Generate device-tree blobs for use with MathWorks example reference designs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
PACKAGE_ARCH = "${MACHINE_ARCH}"
# Depend on the virtual/kernel for kernel source and cmake-native for CMake
DEPENDS = "virtual/kernel cmake-native dtc-native"

# Specify the source files and other details as needed
SRC_URI = " file://CMakeLists.txt \
	file://common \
	file://zynqmp \
	file://zynq"

S = "${WORKDIR}"

inherit cmake
inherit deploy

# Pass the architecture and cross-compile prefix to CMake
EXTRA_OECMAKE = " -DKERNEL_DIR=${STAGING_KERNEL_DIR} -DMACHINE_OVERRIDES=${MACHINEOVERRIDES} -DCROSS_COMPILE=${TARGET_PREFIX} "

# Install DTBs into the target rootfs so the runtime package exists
do_install() {
    install -d ${D}/boot/mwdtbs
    # Adjust source path if your build outputs DTBs elsewhere
    install -m 0644 ${B}/*.dtb ${D}/boot/mwdtbs/ || true
}

# Also deploy DTBs as build artifacts
do_deploy() {
    install -d ${DEPLOYDIR}/boot/mwdtbs
    install -m 0644 ${B}/*.dtb ${DEPLOYDIR}/boot/mwdtbs/ || true
}

addtask deploy after do_compile before do_build

# Package the installed DTBs into the main runtime package
FILES:${PN} += "/boot/mwdtbs/*.dtb"

# Skip QA warning if some machines don’t produce files
INSANE_SKIP:${PN} += "installed-vs-skipped"
