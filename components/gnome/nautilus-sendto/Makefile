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

BUILD_BITS=		64
COMPILER=		gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		nautilus-sendto
COMPONENT_VERSION=	3.8.2
COMPONENT_PROJECT_URL=  https://wiki.gnome.org/Apps/Files
COMPONENT_ARCHIVE_HASH= \
	sha256:932811e781457b1dbf7b396e930d588f433b9ba756b10bde9f03f6d71d54bdc5
COMPONENT_BUGDB=	gnome/nautilus
COMPONENT_ANITYA_ID=	13155

COMPONENT_BAID=		28519

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/gnome-component.mk

# Assumes GNU xgettext in PATH
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)

CONFIGURE_OPTIONS += --disable-static
CONFIGURE_OPTIONS += --enable-shared

REQUIRED_PACKAGES += library/glib2
