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
BUILD_BITS= 64
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		spawn-fcgi
COMPONENT_VERSION=	1.6.3
COMPONENT_PROJECT_URL=	http://www.lighttpd.net/
COMPONENT_ARCHIVE_HASH=	\
    sha256:7507a822995731629149040ee5686279b7582ae46f0296efd64b542ef052a90e
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)download/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	5388

COMPONENT_BAID=		16752

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk
