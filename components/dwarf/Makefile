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
# Copyright (c) 2017, 2021, Oracle and/or its affiliates.
#
COMPILER=gcc
BUILD_BITS= 64_and_32
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		dwarf
COMPONENT_VERSION=	20191104
# Convert YYYYMMDD -> YYYY.MM.DD
COMPONENT_PROJECT_URL=	https://www.prevanders.net/dwarf.html
COMPONENT_SRC=	lib$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_URL=	https://www.prevanders.net/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	\
    sha256:45f50a966314421b7dab525859853616df6c9680f0ccf2f44b030c505236eaba
COMPONENT_BUGDB=	library/libdwarf
COMPONENT_ANITYA_ID=	1597

COMPONENT_BAID=		73000

HUMAN_VERSION= $(shell echo $(COMPONENT_VERSION) | \
	$(GSED) -e 's/\(.\{4\}\)\(.\{2\}\)/0.\1.\2./')
IPS_COMPONENT_VERSION=	$(shell echo $(HUMAN_VERSION) | \
	$(GSED) -e 's/\.0/./g')

COMPONENT_PREP_ACTION = (cd $(@D); $(AUTORECONF) -if)

# the community doesn't have an install target yet
INSTALL_TARGET=	build

TEST_TARGET= $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

# Use the headers from the workspace for lint library generation.
LINT_FLAGS += -I$(SOURCE_DIR)/libdwarf
LINT_FLAGS += -I$(BUILD_DIR_$(BITS))/libdwarf

COMPONENT_INSTALL_ENV += PATH="$(GNUBIN):$(USRBIN):$(USRBIN.32):$(GCC_ROOT)/bin"

CONFIGURE_OPTIONS +=	--enable-shared
CONFIGURE_OPTIONS +=	--disable-nonshared

# Makefile.am files of this component are not compatible with Solaris make.
# Use GNU make to avoid the configuration error when makefile fragments are processed.
CONFIGURE_OPTIONS +=  MAKE=$(GMAKE)

REQUIRED_PACKAGES += library/zlib
REQUIRED_PACKAGES += system/library
REQUIRED_PACKAGES += system/linker
