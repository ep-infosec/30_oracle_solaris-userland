#
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
BUILD_BITS= NO_ARCH
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=         gnu-gs-fonts-other
COMPONENT_VERSION=      6.0
COMPONENT_PROJECT_URL=	https://sourceforge.net/projects/gs-fonts/
COMPONENT_ARCHIVE_HASH= \
    sha256:8146cccc4699fe9dab841446bdd17039f4769c903eceb54409188b920754aab3
COMPONENT_ARCHIVE_URL=  https://download.sourceforge.net/sourceforge/gs-fonts/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	utility/ghostscript
COMPONENT_ANITYA_ID=	13312

COMPONENT_BAID=		7589

# set relocate_to option while unpacking the tar ball
UNPACK_ARGS= -r $(COMPONENT_SRC)

PROTOGSSHAREDIR=$(PROTOUSRSHAREDIR)/ghostscript

BUILD_STYLE= archive
include $(WS_MAKE_RULES)/common.mk

# untar the tar ball and apply the patches
build:		$(SOURCE_DIR)/.prep

install: build
	$(MKDIR) $(PROTO_DIR)
	$(MKDIR) -m 755 -p $(PROTOGSSHAREDIR)
	$(CP) -r $(SOURCE_DIR)/* $(PROTOGSSHAREDIR)

test:	$(NO_TESTS)

system-test:    $(NO_TESTS)

