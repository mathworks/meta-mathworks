# Force LIBIIO version to 0.25
BRANCH ?= "libiio-v0"
SRC_URI = "git://github.com/analogdevicesinc/libiio.git;protocol=https;branch=${BRANCH}"
PV = "0.25+git${SRCPV}"


