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
# Copyright (c) 2018, 2021, Oracle and/or its affiliates.
#

BUILD_BITS =            64_and_32
COMPILER=               gcc
include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libdrm
COMPONENT_VERSION=	2.4.100
COMPONENT_PROJECT_URL=  https://dri.freedesktop.org/
COMPONENT_ARCHIVE_HASH= \
	sha256:c77cc828186c9ceec3e56ae202b43ee99eb932b4a87255038a80e8a1060d0a5d
COMPONENT_ARCHIVE_URL=  $(COMPONENT_PROJECT_URL)libdrm/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).sig
COMPONENT_BUGDB=        x11/libraries
COMPONENT_ANITYA_ID=	1596
COMPONENT_BAID=		76453

TEST_TARGET = $(NO_TESTS)

CONFIGURE_LIBDIR.32 = $(USRLIBDIR)/xorg
CONFIGURE_LIBDIR.64 = $(USRLIBDIR)/xorg/$(MACH64)

FIX_PC_FILES=libdrm.pc.in libkms/libkms.pc.in

include $(WS_MAKE_RULES)/x11-component.mk

# GNU Build System files have to be regenerated for automake 1.16.
# It can be removed when the upstream starts to use a newer automake version.
COMPONENT_PREP_ACTION = (cd $(@D); autoreconf -fiv)

CONFIGURE_OPTIONS += --enable-libkms
CONFIGURE_OPTIONS += --disable-amdgpu
CONFIGURE_OPTIONS += --disable-intel
CONFIGURE_OPTIONS += --disable-nouveau
CONFIGURE_OPTIONS += --disable-radeon
CONFIGURE_OPTIONS += --disable-udev

# Makefile.am files of this component are not compatible with Solaris make.
# Use GNU make to avoid the configuration error when makefile fragments are processed.
CONFIGURE_OPTIONS += MAKE=$(GMAKE)

COMPONENT_INSTALL_ARGS.32 += pkgconfigdir="$(DESTDIR)/usr/lib/pkgconfig"
COMPONENT_INSTALL_ARGS.64 += pkgconfigdir="$(DESTDIR)/usr/lib/$(MACH64)/pkgconfig"

REQUIRED_PACKAGES += diagnostic/scanpci
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += x11/library/libpthread-stubs
