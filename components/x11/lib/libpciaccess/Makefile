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
# Copyright (c) 2018, 2022, Oracle and/or its affiliates.
#

BUILD_BITS =            64_and_32
include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libpciaccess
COMPONENT_VERSION=	0.17
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:74283ba3c974913029e7a547496a29145b07ec51732bbb5b5c58d5025ad95b73
COMPONENT_BUGDB=        x11/libraries
COMPONENT_ANITYA_ID=	1703
COMPONENT_BAID=		132854

# required because of a patched Makefile.am
COMPONENT_PREP_ACTION = (cd $(@D); $(AUTORECONF_ENV) autoreconf -fiv);

PKG_PROTO_DIRS +=  $(BUILD_DIR_64)/scanpci/.libs
PKG_PROTO_DIRS +=  $(BUILD_DIR_64)/man

TEST_TARGET = $(NO_TESTS)

FIX_PC_FILES=pciaccess.pc.in

include $(WS_MAKE_RULES)/x11-component.mk

REQUIRED_PACKAGES += system/library/devinfo
