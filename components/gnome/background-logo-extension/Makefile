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
# Copyright (c) 2016, 2022, Oracle and/or its affiliates.
#

include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		background-logo-extension
COMPONENT_VERSION=	41.0
COMPONENT_PROJECT_URL=  https://extensions.gnome.org/extension/889/background-logo
COMPONENT_ARCHIVE_HASH= \
	sha256:7cd2f17166db747678c9347e44bced98050b24afba306a88f7148fdf6597dc9e
COMPONENT_ARCHIVE_URL=	http://releases.pagure.org/background-logo-extension/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	gnome/gnome-shell
COMPONENT_ANITYA_ID=	13118

COMPONENT_BAID=		116235
BUILD_STYLE=		meson

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/gnome-component.mk

REQUIRED_PACKAGES += gnome/gnome-shell
REQUIRED_PACKAGES += library/desktop/clutter
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/desktop/gtk3
REQUIRED_PACKAGES += library/gnome/gnome-desktop
