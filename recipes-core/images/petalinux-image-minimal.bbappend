IMAGE_INSTALL_append = " boost"
IMAGE_INSTALL_append = " openssh-sftp-server"
IMAGE_INSTALL_append = " libubootenv-bin"
IMAGE_INSTALL_append = " busybox-udhcpd busybox-udhcpc busybox-inetd"
IMAGE_INSTALL_append = " libiio libiio-iiod libserialport "
IMAGE_INSTALL_append = " lttng-ust lttng-ust-bin lttng-tools lttng-modules"
IMAGE_INSTALL_append = " avahi-utils avahi-daemon avahi-autoipd"
IMAGE_INSTALL_append = " dtc"
IMAGE_INSTALL_append = " procps"
IMAGE_INSTALL_append = " libsysfs sysfsutils libmetal libconfig"


inherit extrausers
# Set root password as "root" (argument -p for usermod is obtained using 'mkpasswd -m sha-512 root')
EXTRA_USERS_PARAMS = " \
usermod -p '\$6\$IAKCcKX.GF8zHrGx\$rlHKYUuXoHiIQgqvqCEFLCr0x7Ela7wMvXmPLmikcK4LVuIcPOTeQ9OibhBf1k9/FV/O4362DRng2NC6IFO680' root\
"

# SSHD_CONFIG
SSHD_CONFIG_FILE ?= "${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config"
# DROPBEAR config
DROPBEAR_CONFIG_FILE ?= "${IMAGE_ROOTFS}${sysconfdir}/default/dropbear"

# Modify the serial console config and the video console config files.
GETTY_SYSVINIT_UNIT ?= "${IMAGE_ROOTFS}${sysconfdir}/inittab"
GETTY_SYSTEMD_UNITS ?= " \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
#  Modify the systemd unit configuration files
l_enable_autologin () {
	for unit in ${GETTY_SYSTEMD_UNITS}; do
		if [ -f $unit ]; then
		    sed -i -e 's/^\(ExecStart *=.*getty \)/\1--autologin root /' $unit
		fi
	done
#	if [ -f ${GETTY_SYSVINIT_UNIT} ]; then
#	    sed -i 's/\/bin\/start_getty\(.*\)/\/sbin\/getty\1 -a root/' ${GETTY_SYSVINIT_UNIT} 
#	fi
}

l_permit_sshrootlogin () {
	if [ -f ${SSHD_CONFIG_FILE} ]; then
	    sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' ${SSHD_CONFIG_FILE}
	fi
	if [ -f ${DROPBEAR_CONFIG_FILE} ]; then
	    sed -i 's/-w//g' ${DROPBEAR_CONFIG_FILE}
	fi
}

ROOTFS_POSTPROCESS_COMMAND_append = "l_enable_autologin; \
				     l_permit_sshrootlogin;"


