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
# Copyright (c) 2011, 2021, Oracle and/or its affiliates.
#
BUILD_BITS= 64
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		convmv
COMPONENT_VERSION=	2.03
IPS_COMPONENT_VERSION=  2.3
HUMAN_VERSION=		2.03
COMPONENT_PROJECT_URL=	http://www.j3e.de/linux/convmv/
COMPONENT_ARCHIVE_HASH=	\
    sha256:f898fd850c8ef5abe48f7536e4b23ce4e11b6133974b2fc41d9197dfecc1c027
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	342

COMPONENT_BAID=		42188

BUILD_STYLE= justmake
include $(WS_MAKE_RULES)/common.mk

PATCH_LEVEL=0

COMPONENT_TEST_TRANSFORMS += \
	'-e "s/ in [0-9][0-9]*\.*[0-9]* seconds.//" ' \
	'-e "/^unimplemented function: utime.*$$/d" '

COMPONENT_TEST_TARGETS=		test
COMPONENT_SYSTEM_TEST_TARGETS=	test
COMPONENT_SYSTEM_TEST_ENV=	CONVMV=$(USRBINDIR)/convmv

# Adjust '#!/usr/bin/perl'
PERL_SCRIPTS = \
	$(PROTOUSRBINDIR)/convmv

ASLR_MODE = $(ASLR_NOT_APPLICABLE)

system-test:    $(SYSTEM_TEST_64)

REQUIRED_PACKAGES += $(PERL_PKG)
