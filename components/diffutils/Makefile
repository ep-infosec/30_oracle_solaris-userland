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
COMPILER= gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		diffutils
COMPONENT_VERSION=	3.8
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_HASH=	\
    sha256:a6bdd7d1b31266d11c4f4de6c1b748d4607ab0231af5188fc2533d0ae2438fec
COMPONENT_BUGDB=	utility/gnu-diffutils
COMPONENT_ANITYA_ID=	436

COMPONENT_BAID=		110266

SYSTEM_TEST_TARGET= configure $(SYSTEM_TEST_64)

ifeq ($(MACH),i386)
# The unit tests failed to start.
$(SKIP_TEST_AT_TOP_LEVEL)
endif

include $(WS_MAKE_RULES)/gnu-component.mk

COMPONENT_PREP_ACTION =		(cd $(@D) ; autoreconf -f)

CONFIGURE_PREFIX= $(USRGNUDIR)
CONFIGURE_OPTIONS  +=		--infodir=$(CONFIGURE_INFODIR)
CONFIGURE_OPTIONS  +=		--localedir=$(USRSHARELOCALEDIR)

# Needed for "gmake test" to work successfully.
# If SHELLOPTS is exported (as it is by the userland makefiles),
# then all shell options get exported to child invocations of bash,
# which results in test failures due to nounset and xtrace being
# set unexpectedly, and errors such as "$1: unbound variable" and
# diffs failing due to script tracing in output files.
unexport SHELLOPTS

COMPONENT_TEST_DIR =	$(@D)/tests

COMPONENT_TEST_TRANSFORMS += \
	'-e "s|^make.*: Leaving directory.*$$|XXX_CC_XXX|g" ' \
	'-e "s|^make.*: Entering directory.*$$|XXX_CC_XXX|g" ' \
	'-e "s|^make.*: Nothing to be.*$$|XXX_CC_XXX|g" ' \
	'-e "s|^/usr/gnu/bin/make.*$$|XXX_CC_XXX|g" ' \
	'-e "/^XXX_CC_XXX$$/d" '

COMPONENT_SYSTEM_TEST_DIR =	$(@D)/tests
COMPONENT_SYSTEM_TEST_ENV +=	PATH="$(GNUBIN):$(PATH)"

REQUIRED_PACKAGES += library/libsigsegv
REQUIRED_PACKAGES += system/library
