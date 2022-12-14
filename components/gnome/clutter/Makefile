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

BUILD_BITS =            32_and_64
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER =              gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		clutter
COMPONENT_VERSION=	1.26.4
COMPONENT_PROJECT_URL=	http://www.clutter-project.org/
COMPONENT_ARCHIVE_HASH=	\
	sha256:8b48fac159843f556d0a6be3dbfc6b083fc6d9c58a20a49a6b4919ab4263c4e6
COMPONENT_BUGDB=        library/clutter
COMPONENT_ANITYA_ID=	302

COMPONENT_BAID=		88323

# Requires a display
TEST_TARGET = $(SKIP_TEST)

include $(WS_MAKE_RULES)/gnome-component.mk

# Uses gcc extensions for void returns.
CFLAGS.studio += $(studio_FEATURES_EXTENSIONS)

CONFIGURE_OPTIONS += --disable-static
# Explicitly disabling egl backend cos otherwise it looks for cogl-egl.h
# which isn't delivered because it requires wayland support
CONFIGURE_OPTIONS += --disable-egl-backend
# Required for other components.
CONFIGURE_OPTIONS.32 += --disable-introspection
CONFIGURE_OPTIONS.64 += --enable-introspection
CONFIGURE_OPTIONS += --enable-shared
# Required for other components.
CONFIGURE_OPTIONS += --enable-gdk-backend
# Required for other components.
CONFIGURE_OPTIONS += --enable-gdk-pixbuf
# Required for other components.
CONFIGURE_OPTIONS += --enable-x11-backend
# Required for other components.
CONFIGURE_OPTIONS += --enable-xinput
CONFIGURE_OPTIONS += --with-pic
CONFIGURE_OPTIONS += --with-x

REQUIRED_PACKAGES += developer/documentation-tool/gtk-doc
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/graphics/cogl
REQUIRED_PACKAGES += library/json-glib
REQUIRED_PACKAGES += system/library/fontconfig
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxcomposite
REQUIRED_PACKAGES += x11/library/libxdamage
REQUIRED_PACKAGES += x11/library/libxi
