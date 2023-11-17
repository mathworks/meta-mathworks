IMAGE_INSTALL:append = " boost"
IMAGE_INSTALL:append = " libubootenv-bin"
IMAGE_INSTALL:append = " libusb-compat libserialport libiio libiio-iiod libiio-tests "
IMAGE_INSTALL:append = " lttng-ust lttng-ust-bin lttng-tools lttng-modules"
IMAGE_INSTALL:append = " avahi-utils avahi-daemon avahi-autoipd"
IMAGE_INSTALL:append = " dtc"
IMAGE_INSTALL:append = " procps"


# Add a non-root sudo user "petalinux", set the password and enable auto-login

inherit extrausers
# Set root password as "root" (argument -p for usermod is obtained using 'mkpasswd -m sha-512 root')
EXTRA_USERS_PARAMS = " \
useradd -p '\$6\$IAKCcKX.GF8zHrGx\$rlHKYUuXoHiIQgqvqCEFLCr0x7Ela7wMvXmPLmikcK4LVuIcPOTeQ9OibhBf1k9/FV/O4362DRng2NC6IFO680' petalinux \
"

EXTRA_USERS_SUDOERS = "petalinux ALL=(ALL) ALL;"

# SSHD_CONFIG
SSHD_CONFIG_FILE ?= "${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config"

# Modify the serial console config and the video console config files.
GETTY_SYSVINIT_UNIT ?= "${IMAGE_ROOTFS}${sysconfdir}/inittab"
GETTY_SYSTEMD_UNITS ?= " \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
#  Modify the systemd unit configuration files
l_enable_autologin () {
	if [ -f ${GETTY_SYSTEMD_UNITS} ]; then
	    sed -i -e 's/^\(ExecStart *=.*getty \)/\1--autologin petalinux /' ${GETTY_SYSTEMD_UNITS}
	fi
	if [ -f ${GETTY_SYSVINIT_UNIT} ]; then
	    sed -i 's/\/bin\/start_getty\(.*\)/\/sbin\/getty\1 -a root/' ${GETTY_SYSVINIT_UNIT} 
	fi
}

l_permit_sshrootlogin () {
	if [ -f ${SSHD_CONFIG_FILE} ]; then
	    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' ${SSHD_CONFIG_FILE}
	fi
}

ROOTFS_POSTPROCESS_COMMAND:append = "l_enable_autologin; \
				     l_permit_sshrootlogin;"

