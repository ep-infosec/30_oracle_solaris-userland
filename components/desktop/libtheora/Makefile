#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2016, 2021, Oracle and/or its affiliates.
#

BUILD_BITS=            	32_and_64
COMPILER=		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libtheora
COMPONENT_VERSION=	1.1.1
COMPONENT_PROJECT_URL=	http://theora.org/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH= \
	sha256:b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc
COMPONENT_ARCHIVE_URL=	http://downloads.xiph.org/releases/theora/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	gnome/multimedia
COMPONENT_ANITYA_ID=	11793

COMPONENT_BAID=		8535

ifeq ($(MACH),i386)
# Disable tests since there are some crashes.
$(SKIP_TEST_AT_TOP_LEVEL)
endif

include $(WS_MAKE_RULES)/common.mk

# Assumes GNU versions of utilities in PATH (e.g. tail).
COMPONENT_BUILD_ENV += PATH="$(GNUBIN):$(PATH)"

CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --disable-examples
LDFLAGS += -lm

# for the tests
unexport SHELLOPTS
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master
COMPONENT_TEST_ARGS =   -k -i
COMPONENT_TEST_TRANSFORMS += \
        '-n ' \
        '-e "/TOTAL:/p" ' \
        '-e "/SKIP:/p" ' \
        '-e "/PASS:/p" ' \
        '-e "/FAIL:/p" ' \
        '-e "/ERROR:/p" '

REQUIRED_PACKAGES += codec/libogg
REQUIRED_PACKAGES += developer/documentation-tool/doxygen
REQUIRED_PACKAGES += library/sdl
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
