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
include ../../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libpthread-stubs
COMPONENT_VERSION=	0.4
COMPONENT_CATEGORY=	xcb
COMPONENT_PROJECT_URL=	https://xcb.freedesktop.org/
COMPONENT_ARCHIVE_HASH= \
	sha256:e4d05911a3165d3b18321cc067fdd2f023f06436e391c6a28dff618a78d2e733
COMPONENT_BUGDB=        x11/libraries
COMPONENT_ANITYA_ID=	13519
COMPONENT_BAID=		58942
COMPONENT_SIG_URL=

TEST_TARGET = $(NO_TESTS)

FIX_PC_FILES=pthread-stubs.pc.in

include $(WS_MAKE_RULES)/x11-component.mk
