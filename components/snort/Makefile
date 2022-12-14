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
# Copyright (c) 2011, 2022, Oracle and/or its affiliates.
#
BUILD_BITS= 64
COMPILER= gcc

include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		snort
COMPONENT_VERSION=	2.9.20
COMPONENT_ARCHIVE_HASH=	sha256:29400e13f53b1831e0b8b10ec1224a1cbaa6dc1533a5322a20dd80bb84b4981c
COMPONENT_PROJECT_URL=	https://www.snort.org/
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)downloads/archive/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	13263

COMPONENT_BAID=		130312

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# Need to recreate the configure script for gethrtime checks.
COMPONENT_PREP_ACTION +=	(cd $(@D); autoreconf -fiv);

PKG_CONFIG_PATHS += /usr/openssl/3/lib/64/pkgconfig

# Without this, linker flags from pkgconfig are added too late to take effect
LDFLAGS += -L/usr/openssl/3/lib/64
COMPONENT_BUILD_ARGS += LDFLAGS="$(LDFLAGS)"

CONFIGURE_OPTIONS +=	--disable-static-daq
CONFIGURE_OPTIONS +=	--disable-open-appid

REQUIRED_PACKAGES += compress/xz
REQUIRED_PACKAGES += developer/lexer/flex
REQUIRED_PACKAGES += developer/parser/bison
REQUIRED_PACKAGES += library/nghttp2
REQUIRED_PACKAGES += library/pcre
REQUIRED_PACKAGES += library/security/openssl-3
REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += shell/ksh93
REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += system/library/libdaq
REQUIRED_PACKAGES += system/library/libdnet
REQUIRED_PACKAGES += system/library/libpcap
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/network
