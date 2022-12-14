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

BUILD_ARCH= i386
BUILD_BITS= 64
# component fails to build with Studio
COMPILER= gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		sbsigntool
COMPONENT_VERSION=	0.6
COMPONENT_PROJECT_URL=  https://launchpad.net/ubuntu/+source/sbsigntool
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)_$(COMPONENT_VERSION).orig.tar.gz
COMPONENT_ARCHIVE_HASH= \
    sha256:84fb0c8f6fb1e79aa418a4f70a3139b38d5630043b28291c875f383e9b4294b8
COMPONENT_ARCHIVE_URL=  https://launchpad.net/ubuntu/+archive/primary/+files/$(COMPONENT_ARCHIVE)

COMPONENT_ANITYA_ID=	16340
COMPONENT_BAID=	        32807

include $(WS_MAKE_RULES)/common.mk

studio_C99MODE= $(studio_C99_ENABLE)
CFLAGS += -I. -I/usr/gnu/include -I/usr/include/ -I/usr/include/efi/x86_64 -I/usr/include/efi/
PATH=/usr/gnu/bin:/usr/bin

# GNU Build System files have to be regenerated for automake 1.16.
# It can be removed when the upstream starts to use a newer automake version.
COMPONENT_PREP_ACTION = \
        (cd $(@D) ; autoreconf -fiv)

COMPONENT_PRE_TEST_ACTION = \
        (cp test-x86_64_sol2.lds  $(SOURCE_DIR)/tests/.)

include $(WS_MAKE_RULES)/shared-targets.mk

COMPONENT_TEST_TRANSFORMS += \
	'-n -e "/tests passed/p" ' \
	'-e "/PASS/p" ' \
	'-e "/FAIL/p" '

ifeq ($(MACH), i386)
REQUIRED_PACKAGES += library/libgnuefi
endif
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += library/security/openssl/openssl-fips-140
