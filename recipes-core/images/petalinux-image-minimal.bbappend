IMAGE_INSTALL:append = " boost"
IMAGE_INSTALL:append = " libubootenv-bin"
IMAGE_INSTALL:append = " libiio libiio-iiod libserialport "
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


# Modify the serial console config and the video console config files.
GETTY_SYSTEMD_UNITS ?= " \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/serial-getty@.service \
     ${IMAGE_ROOTFS}${systemd_system_unitdir}/getty@.service \
"
#  Modify the systemd unit configuration files
l_enable_autologin () {
    sed -i -e 's/^\(ExecStart *=.*getty \)/\1--autologin petalinux /' ${GETTY_SYSTEMD_UNITS}
}

ROOTFS_POSTPROCESS_COMMAND:append = "l_enable_autologin;"
