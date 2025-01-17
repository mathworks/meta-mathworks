FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"


DESCRIPTION = "ADI kernel"
LINUX_VERSION = "6.1.70"
ADI_VERSION = "2023_R2"

PV = "${LINUX_VERSION}-${ADI_VERSION}+git${SRCPV}"
KBRANCH = "2023_R2"
# needed for offline build
SRCREV = "${@ "54eb23f4b5c6093916f208772627f7b68f495559" if bb.utils.to_boolean(d.getVar('BB_NO_NETWORK')) else d.getVar('AUTOREV')}"
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
       file://usb_gadget.cfg        \
       file://0001-drivers-dma-Remove-partial-transfers-for-ADI-DMAC.patch \
       file://0002-drivers-misc-mathworks-Update-get_irq-reset-tlast.patch \
       "


