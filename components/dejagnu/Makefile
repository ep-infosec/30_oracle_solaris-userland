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
# Copyright (c) 2013, 2022, Oracle and/or its affiliates.
#
BUILD_BITS= 64
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		dejagnu
COMPONENT_VERSION=	1.6.3
COMPONENT_ARCHIVE_HASH=	\
    sha256:87daefacd7958b4a69f88c6856dbd1634261963c414079d0c371f589cd66a2e3
COMPONENT_ANITYA_ID=	417

COMPONENT_BAID=		117209

SYSTEM_TEST_TARGET= configure $(SYSTEM_TEST_64)
include $(WS_MAKE_RULES)/gnu-component.mk

COMPONENT_TEST_ENV +=	PATH="$(GNUBIN):$(PATH)"

COMPONENT_TEST_TRANSFORMS += \
	'-n ' \
	'-e "/Running/p" ' \
	'-e "/\# of /p" '

COMPONENT_SYSTEM_TEST_ENV +=	PATH="$(GNUBIN):$(PATH)"
COMPONENT_SYSTEM_TEST_ENV +=	RUNTEST_SCRIPT=/usr/bin/runtest

ASLR_MODE = $(ASLR_NOT_APPLICABLE)

REQUIRED_PACKAGES += shell/expect
REQUIRED_PACKAGES += shell/ksh93
