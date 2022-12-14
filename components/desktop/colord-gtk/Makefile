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
# Copyright (c) 2015, 2021, Oracle and/or its affiliates.
#

BUILD_BITS =            64_and_32
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		colord-gtk
COMPONENT_VERSION=	0.1.26
COMPONENT_PROJECT_URL=	https://www.freedesktop.org/software/colord/
COMPONENT_ARCHIVE=      $(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH= \
	sha256:28d00b7f157ea3e2ea5315387b2660fde82faba16674861c50465e55d61a3e45
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)/releases/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).asc
COMPONENT_BUGDB=	gnome/libraries
COMPONENT_ANITYA_ID=	331

COMPONENT_BAID=		27550

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

# Assumes GNU xgettext in PATH
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)

# We should only need gtk3 support.
CONFIGURE_OPTIONS += --disable-gtk2
# Documentation target is busted; also requires docbook2man.
CONFIGURE_OPTIONS += --disable-gtk-doc
CONFIGURE_OPTIONS += --disable-schemas-compile
CONFIGURE_OPTIONS += --disable-static
# Required for other components.
CONFIGURE_OPTIONS.32 += --disable-introspection
CONFIGURE_OPTIONS.64 += --enable-introspection
CONFIGURE_OPTIONS += --enable-shared
# Required for other components.
CONFIGURE_OPTIONS += --enable-vala
CONFIGURE_OPTIONS += --with-pic

REQUIRED_PACKAGES += developer/vala
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += service/image/colord
