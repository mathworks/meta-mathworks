DESCRIPTION = "ADI kernel"
LINUX_VERSION = "5.10"
ADI_VERSION = "adi_2021_R2"

PV = "${LINUX_VERSION}-${ADI_VERSION}+git${SRCPV}"
KBRANCH = "2021_R2"
# needed for offline build
SRCREV = "${@ "e966bb2dd74fa12c989e5b9485fe63cca5c9bfee" if bb.utils.to_boolean(d.getVar('BB_NO_NETWORK')) else d.getVar('AUTOREV')}"
KERNELURI = "git://github.com/analogdevicesinc/linux.git;protocol=https"

# override kernel config file
KBUILD_DEFCONFIG_zynq = "zynq_xcomm_adv7511_defconfig"
KBUILD_DEFCONFIG_zynqmp = "adi_zynqmp_defconfig"
KBUILD_DEFCONFIG_microblaze = "adi_mb_defconfig"

SRC_URI_append = " file://bsp.cfg"
KERNEL_FEATURES_append = " bsp.cfg"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://usb_gadget.cfg \
	    file://user_2022-05-23-16-27-00.cfg \
            file://user_2022-06-15-16-56-00.cfg \
            file://user_2022-07-05-15-54-00.cfg \
            file://user_2022-07-05-16-34-00.cfg \
            file://user_2022-08-25-16-58-00.cfg \
            file://0001-drivers-misc-mathworks-Add-support-for-sharedmem-cha.patch \
            file://0002-drivers-dma-Remove-partial-transfers-for-ADI-DMAC.patch \
	    file://0002-drivers-misc-mathworks-Update-get_irq-reset-tlast.patch \
            "
