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

BUILD_BITS= 64_and_32
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libotr
COMPONENT_VERSION=	4.1.1
COMPONENT_PROJECT_URL=	https://otr.cypherpunks.ca/
COMPONENT_ARCHIVE_HASH= \
    sha256:8b3b182424251067a952fb4e6c7b95a21e644fbb27fbd5f8af2b2ed87ca419f5
COMPONENT_ARCHIVE_URL=	$(COMPONENT_PROJECT_URL)$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	utility/pidgin
COMPONENT_ANITYA_ID=	13303

COMPONENT_BAID=		29988

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

CFLAGS +=	-I $(SOURCE_DIR)/src

COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	glib-gettextize -f ; \
	libtoolize --force ; \
	aclocal -I . ; \
	autoheader ; \
	automake -a -c -f ; \
	autoconf )

REQUIRED_PACKAGES += system/library/security/libgcrypt
