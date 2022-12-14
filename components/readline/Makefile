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
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		readline
COMPONENT_VERSION=	8.1
COMPONENT_PROJECT_URL=	https://tiswww.cwru.edu/php/chet/readline/rltop.html
COMPONENT_ARCHIVE_HASH=	\
    sha256:232422a8d83958670b8e4112dc57379bef55ab9ff764c5686a1b2b4a9bb10b79
COMPONENT_BUGDB=	library/readline
COMPONENT_ANITYA_ID=	4173

COMPONENT_BAID_V8=	101888
COMPONENT_BAID_V7=	38098

# For now, we want to continue to provide the libreadline and libhistory so's
# (and their links) from readline 7.0.
#
COMPONENT_VERSION_1 =   7.0
COMPONENT_SRC_1 =       $(COMPONENT_NAME)-$(COMPONENT_VERSION_1)
COMPONENT_ARCHIVE_1 =   $(COMPONENT_SRC_1).tar.gz
COMPONENT_ARCHIVE_HASH_1 = \
    sha256:750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334
COMPONENT_ARCHIVE_URL_1 = https://ftp.gnu.org/gnu/readline/$(COMPONENT_ARCHIVE_1)
COMPONENT_SIG_URL_1=	$(COMPONENT_ARCHIVE_URL_1).sig
SOURCE_DIR_1 =          $(COMPONENT_DIR)/$(COMPONENT_SRC_1)

BUILD_TARGET=
INSTALL_TARGET=
TEST_TARGET= install $(TEST_32)
SYSTEM_TEST_TARGET= configure $(SYSTEM_TEST_32)
include $(WS_MAKE_RULES)/gnu-component.mk

LINT_FLAGS += -I$(PROTOUSRINCDIR)

# readline likes to use ld directly and this is the easiest
# way to get it to add -lc
LDFLAGS += -lc
CONFIGURE_OPTIONS  +=		--infodir=$(CONFIGURE_INFODIR)
CONFIGURE_OPTIONS  +=		--enable-shared

# Build the readline examples as well.
COMPONENT_BUILD_TARGETS =	everything

COMPONENT_TEST_DIR =		$(@D)/examples
COMPONENT_TEST_CMD =		$(CAT) $(SOURCE_DIR)/examples/Inputrc | ./rlcat
COMPONENT_TEST_TARGETS =

# Master test results are the same for 32-bit and 64-bit, so override
# here, rather than create multiple identical master files.
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-all.master

# Needed to build the test program.
COMPONENT_PRE_TEST_ACTION += \
	(cd $(@D) ; $(GMAKE) libreadline.a ) ;

# Build the test program.
COMPONENT_PRE_TEST_ACTION += \
	(cd $(@D)/examples ; $(GMAKE) rlcat ) ;

# Needed to build the test program.
COMPONENT_PRE_SYSTEM_TEST_ACTION += \
	(cd $(@D) ; $(GMAKE) libreadline.a ) ;

# Build the test program.
COMPONENT_PRE_SYSTEM_TEST_ACTION += \
	(cd $(@D)/examples ; $(GMAKE) rlcat ) ;

# Get correct libreadline.so.8 from the proto area.
TEST_LIBPATH.32 =       $(PROTOUSRLIBDIR)
TEST_LIBPATH.64 =       $(PROTOUSRLIBDIR64)
COMPONENT_TEST_ENV +=   LD_LIBRARY_PATH=$(TEST_LIBPATH.$(BITS))

COMPONENT_SYSTEM_TEST_DIR =	$(@D)/examples
COMPONENT_SYSTEM_TEST_CMD =	$(CAT) $(SOURCE_DIR)/examples/Inputrc | ./rlcat
COMPONENT_SYSTEM_TEST_TARGETS =

# Macros to configure, build, and install the old version for the time being.
BUILD_OLD_DIR_32 = $(COMPONENT_DIR)/build/$(COMPONENT_VERSION_1)-$(MACH32)
BUILD_OLD_DIR_64 = $(COMPONENT_DIR)/build/$(COMPONENT_VERSION_1)-$(MACH64)

$(BUILD_OLD_DIR_32)/.configured: CONFIGURE_SCRIPT = $(SOURCE_DIR_1)/configure
$(BUILD_OLD_DIR_64)/.configured: CONFIGURE_SCRIPT = $(SOURCE_DIR_1)/configure
$(BUILD_OLD_DIR_32)/.configured:        BITS=32
$(BUILD_OLD_DIR_64)/.configured:        BITS=64

BUILD_32 += $(BUILD_OLD_DIR_32)/.built
BUILD_64 += $(BUILD_OLD_DIR_64)/.built

INSTALL_32 += $(BUILD_OLD_DIR_32)/.installed
INSTALL_64 += $(BUILD_OLD_DIR_64)/.installed

# install the old version first
$(BUILD_DIR_32)/.installed:     $(BUILD_OLD_DIR_32)/.installed
$(BUILD_DIR_64)/.installed:     $(BUILD_OLD_DIR_64)/.installed

PKG_MACROS +=	COMPONENT_VERSION_1=$(COMPONENT_VERSION_1)

build:		$(BUILD_32_and_64)

install:	$(INSTALL_32_and_64)
