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
BUILD_BITS= 		64
COMPILER=		gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		paps
COMPONENT_VERSION=	0.20211014

# due to 27244651 the IPS version should be the solaris version
IPS_COMPONENT_VERSION=	$(PKG_SOLARIS_VERSION)

COMPONENT_PROJECT_URL=	https://github.com/dov/paps
COMPONENT_ARCHIVE_SRC=	git
COMPONENT_BUGDB=	utility/paps
COMPONENT_ANITYA_ID=	2592

GIT_REPO=		https://github.com/dov/paps
GIT_COMMIT_ID=		a8579dfad2695d7c79bb4a4041e33908689f1542

COMPONENT_BAID=		110200

BUILD_STYLE=		meson

TEST_TARGET= $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/library/libc
REQUIRED_PACKAGES += text/gnu-gettext
