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
BUILD_BITS= 64_and_32
COMPILER= gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		tidy
COMPONENT_VERSION=	5.4.0
COMPONENT_PROJECT_URL=	http://www.html-tidy.org/
COMPONENT_SRC_NAME=	tidy-html5
COMPONENT_ARCHIVE_HASH=	\
    sha256:a2d754b7349982e33f12d798780316c047a3b264240dc6bbd4641542e57a0b7a
COMPONENT_ARCHIVE_URL=	https://github.com/htacg/tidy-html5/archive/$(COMPONENT_VERSION).tar.gz
COMPONENT_BUGDB=	library/tidy
COMPONENT_ANITYA_ID=	13267

COMPONENT_BAID=		38574

BUILD_STYLE= cmake

# There are not unit tests.
TEST_TARGET= $(NO_TESTS)
SYSTEM_TEST_TARGET= $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

CMAKE_OPTIONS += -DBUILD_TAB2SPACE=ON

# Needed for the 64-bit tab2space executable.
PKG_PROTO_DIRS += $(BUILD_DIR_64)
