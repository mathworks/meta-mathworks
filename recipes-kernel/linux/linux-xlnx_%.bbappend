DESCRIPTION = "MW kernel"
LINUX_VERSION = "5.15"
ADI_VERSION = "xilinx-mathworks-port1-minimal"

PV = "${LINUX_VERSION}-${ADI_VERSION}+git${SRCPV}"
KBRANCH = "xilinx-mathworks-port1-minimal"
# needed for offline build
SRCREV = "${@ "364f05ff61c92d0c49be26120277a549c1e0b50d" if bb.utils.to_boolean(d.getVar('BB_NO_NETWORK')) else d.getVar('AUTOREV')}"
# KERNELURI = "git://github.com/mathworks/xilinx-linux.git;protocol=https"
KERNELURI = "git://github.com/commodo/linux.git;protocol=https"

# override kernel config file
KBUILD_DEFCONFIG:versal = "xilinx_versal_defconfig"
KBUILD_DEFCONFIG:zynq = "zynq_xcomm_adv7511_defconfig"
KBUILD_DEFCONFIG:zynqmp = "xilinx_zynqmp_defconfig"
KBUILD_DEFCONFIG:microblaze = "adi_mb_defconfig"

# In adi_mb_defconfig, CONFIG_INITRAMFS_SOURCE is enabled by default.
# Since we are in petalinux already, a simpleImage will be build with the proper
# initramfs so that, we don't have to provide an external one...
do_configure:prepend:microblaze() {
	[ -f ${B}/.config ] && sed -i 's,CONFIG_INITRAMFS_SOURCE=.*,,' ${B}/.config
}


FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append += " file://bsp.cfg"
KERNEL_FEATURES:append += " bsp.cfg"
SRC_URI += "file://user_2022-05-23-16-27-00.cfg \
            file://user_2022-06-15-16-56-00.cfg \
            file://user_2022-07-05-15-54-00.cfg \
            file://user_2022-07-05-16-34-00.cfg \
            file://user_2022-08-25-16-58-00.cfg \
            "

