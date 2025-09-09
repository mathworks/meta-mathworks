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
KBUILD_DEFCONFIG:zynq = "zynq_xcomm_adv7511_defconfig"

SRC_URI:append = " file://bsp.cfg"
KERNEL_FEATURES:append = " bsp.cfg"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " file://bsp.cfg "
KERNEL_FEATURES:append = " bsp.cfg "

SRC_URI:append:zynq = " file://fpgamgr.cfg  \
       file://iio_axidmac.cfg          \
       file://kerneltracing.cfg        \
       file://netconsole.cfg        \
       file://usb_gadget.cfg        \
       file://0001-drivers-dma-Remove-partial-transfers-for-ADI-DMAC.patch \
       file://0002-drivers-misc-mathworks-Update-get_irq-reset-tlast.patch \
       file://0003-drivers-dma-xilinx-Add-chan-directions.patch \
       file://0004-industrialio-buffer-dma-improvements.patch  \
       file://0005-Apply-patch-to-update-adv7604.c-for-720p30-support.patch \
       file://0006-patch-for-IPCore-Interrupt-driver.patch \
       file://adrv-conf.cfg            \
       file://hdmi-imageon.cfg         \
       file://drivers.cfg              \
       file://xilinx_dma.cfg  \
       "
SRC_URI:append:zynqmp = " file://fpgamgr.cfg  \
       file://iio_axidmac.cfg          \
       file://kerneltracing.cfg        \
       file://netconsole.cfg           \
       file://usb_gadget.cfg        \
       file://0001-drivers-dma-Remove-partial-transfers-for-ADI-DMAC.patch \
       file://0002-drivers-misc-mathworks-Update-get_irq-reset-tlast.patch \
       file://0003-drivers-dma-xilinx-Add-chan-directions.patch \
       file://0004-industrialio-buffer-dma-improvements.patch  \
       file://0005-Apply-patch-to-update-adv7604.c-for-720p30-support.patch \
       file://0006-patch-for-IPCore-Interrupt-driver.patch \
       file://adrv-conf.cfg            \
       file://hdmi-imageon.cfg         \
       file://drivers.cfg              \
       file://zynqMP.cfg               \
       file://xilinx_dma.cfg  \
       "
