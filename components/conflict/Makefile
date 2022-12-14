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
# Copyright (c) 2011, 2022, Oracle and/or its affiliates.
#
BUILD_BITS= 64
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		conflict
COMPONENT_VERSION=	20210108
IPS_COMPONENT_VERSION=	0.2021.1.8
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tgz
COMPONENT_PROJECT_URL=	http://invisible-island.net/conflict/conflict.html
COMPONENT_ARCHIVE_HASH=	\
    sha256:90e878233d022c4e7507cf9e7424c3131c016b00f00f6661dae7ee1a29239a56
COMPONENT_ARCHIVE_URL=	https://invisible-mirror.net/archives/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).asc
COMPONENT_ANITYA_ID=	13297

COMPONENT_BAID=		118742

# We really do need to build conflict so that it can use the files in the
# build directory. We are using the installed conflict binary to do this
# though when we run the system tests.
SYSTEM_TEST_TARGET= build $(SYSTEM_TEST_64)
include $(WS_MAKE_RULES)/common.mk

# Required to configure correctly.
COMPONENT_PRE_CONFIGURE_ACTION = \
	($(CLONEY) $(SOURCE_DIR) $(@D))

COMPONENT_TEST_DIR =	$(BUILD_DIR_64)
COMPONENT_TEST_CMD =	./run_test.sh
COMPONENT_TEST_TARGETS =

# The additional conflict specific set of transforms to be applied to the
# test results to try to normalize them.
COMPONENT_TEST_TRANSFORMS += \
	'-e "s|/tmp/conflict\.......|/tmp/conflict\.xxxxxx|g" ' \
	'-e "s|^\*\*		\$$(@D)/.*$$|XXX_CC_XXX|g" ' \
	'-e "s|^\*\*		/usr/bin/.*$$|XXX_CC_XXX|g" ' \
	'-e "/^XXX_CC_XXX$$/d" '

COMPONENT_SYSTEM_TEST_DIR =	$(BUILD_DIR_64)
COMPONENT_SYSTEM_TEST_ENV =	CONFLICT_BIN=/usr/bin/conflict
COMPONENT_SYSTEM_TEST_CMD =	./run_test.sh
COMPONENT_SYSTEM_TEST_TARGETS =

# Conflict needs to be installed for its test suite to work
REQUIRED_PACKAGES += shell/conflict
