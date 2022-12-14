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

BUILD_BITS= 		32_and_64
COMPILER= 		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=         libvisual-plugins
COMPONENT_VERSION=      0.4.0
COMPONENT_PROJECT_URL=  http://libvisual.org/
COMPONENT_ARCHIVE_HASH= \
       sha256:8b783a111d54b92502085199c351979d0452b950fcddddd1eae28a16d8508e9b
COMPONENT_ARCHIVE_URL=  https://sourceforge.net/projects/libvisual/files/$(COMPONENT_NAME)/$(COMPONENT_SRC)/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=        gnome/multimedia
COMPONENT_ANITYA_ID=	13114

COMPONENT_BAID=		8407

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

CONFIGURE_OPTIONS += --disable-alsa
CONFIGURE_OPTIONS += --disable-corona
CONFIGURE_OPTIONS += --disable-gforce
CONFIGURE_OPTIONS += --disable-gstreamer-plugin

CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)
COMPONENT_BUILD_ENV += PATH=$(GNUBIN):$(PATH)

REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/libvisual
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += system/library/math
