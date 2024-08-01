FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "ADI kernel"
LINUX_VERSION = "6.1"
ADI_VERSION = "adi-main"

PV = "${LINUX_VERSION}-${ADI_VERSION}+git${SRCPV}"
KBRANCH = "main"
# needed for offline build
SRCREV = "${@ "dc4d9bb93a52833fb3950389e2b9a5be58767eb3" if bb.utils.to_boolean(d.getVar('BB_NO_NETWORK')) else d.getVar('AUTOREV')}"
KERNELURI = "git://github.com/analogdevicesinc/linux.git;protocol=https"

# override kernel config file
KBUILD_DEFCONFIG:versal = "xilinx_versal_defconfig"
KBUILD_DEFCONFIG:zynmp = "adi_zynqmp_defconfig"
KBUILD_DEFCONFIG:zynq = "adi_zynq_defconfig"

SRC_URI:append = " file://bsp.cfg"
KERNEL_FEATURES:append = " bsp.cfg"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg "
KERNEL_FEATURES:append = " bsp.cfg "

SRC_URI:append = " file://fpgamgr.cfg  \
       file://iio_axidmac.cfg          \
       file://kerneltracing.cfg        \
       file://netconsole.cfg        \
       "


