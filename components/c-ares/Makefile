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
# Copyright (c) 2020, 2021, Oracle and/or its affiliates.
#
BUILD_BITS= 64_and_32
COMPILER = gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		c-ares
COMPONENT_VERSION=	1.17.2
COMPONENT_PROJECT_URL=	https://c-ares.haxx.se/
COMPONENT_ARCHIVE_HASH= \
    sha256:4803c844ce20ce510ef0eb83f8ea41fa24ecaae9d280c468c582d2bb25b3913d
COMPONENT_ARCHIVE_URL=	https://c-ares.haxx.se/download/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	library/c-ares
COMPONENT_ANITYA_ID=	5840

COMPONENT_BAID = 106015

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk
