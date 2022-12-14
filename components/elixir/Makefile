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

# Only executable scripts and bytecode files.
BUILD_BITS= NO_ARCH
include ../../make-rules/shared-macros.mk

# Assumes GNU sed for the installation.
PATH=/usr/gnu/bin:/usr/bin:/usr/sbin

COMPONENT_NAME=		elixir
COMPONENT_VERSION=	1.12.1
COMPONENT_PROJECT_URL=	https://elixir-lang.org/
COMPONENT_ARCHIVE_HASH=	\
    sha256:96167d614b9c483efc54bd7898c3eea4768569a77dd8892ada85d7800d5e3ea4
COMPONENT_ARCHIVE_URL=	https://github.com/elixir-lang/$(COMPONENT_NAME)/archive/v$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	utility/elixir
COMPONENT_ANITYA_ID=	673

COMPONENT_BAID=		102960

BUILD_STYLE= justmake

ifeq ($(MACH),sparc)
# Disable tests on SPARC since they are unreproducible with regressions.
$(SKIP_TEST_AT_TOP_LEVEL)
endif

# This is just a workaround to a problem we mostly see on sparc.
# The build stops and never finishes in about 8 % of cases. The process
# erl_child_setup seems to be stuck. Elixir normally builds under five
# minutes, so 15 minutes timeout should be more than enough. This change
# makes sure that elixir is built in 4 attempts and if all attempts fail,
# then there is about 99.995 % probability that there is a problem in
# code or Common Build Environment...
GMAKE := $(WS_TOOLS)/repeat_cmd 4 15m $(GMAKE)
COMPONENT_BUILD_ENV += REPEAT_CMD_CLEANUP="gmake clean"

include $(WS_MAKE_RULES)/common.mk

# Elixir does not like cloney, so a simple copy is used instead.
CLONEY = echo
COMPONENT_PRE_BUILD_ACTION = $(CP) -rp $(SOURCE_DIR)/. $(@D)

COMPONENT_BUILD_TARGETS =	compile
# Required to avoid possible malfunctions.
COMPONENT_BUILD_ENV += LC_ALL=en_US.UTF-8

COMPONENT_INSTALL_TARGETS = install
COMPONENT_INSTALL_ENV +=	DESTDIR=$(PROTO_DIR)
COMPONENT_INSTALL_ENV +=	MANDIR=/usr/share/man
COMPONENT_INSTALL_ENV +=	PREFIX=$(USRDIR)

COMPONENT_TEST_CMD = /usr/bin/gmake test
COMPONENT_TEST_ENV += LC_ALL=en_US.UTF-8
# Remove progress dots, make output, all empty lines, and git lines.
COMPONENT_TEST_TRANSFORMS += '-e "/\.\./d" -e "/^make/d" -e "/^$$/d" -e "/git_repo/d"'
# Ignore runtime statistics and random seeds used for the elixir testing.
COMPONENT_TEST_TRANSFORMS += '-e "/^Finished in/d" -e "/^Randomized with seed/d" -e "/^hint:/d" '
# Ignore the spurious error message (see issue #8183 on elixir github).
COMPONENT_TEST_TRANSFORMS += '-e "/resides in sticky dir/d" -e "/^gmake/d"'
# the hint isn't printed when gmake test is run the second time
COMPONENT_TEST_TRANSFORMS += '-e "/^hint/d"'
# there's a difference between i386 and sparc
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-$(MACH).master

REQUIRED_PACKAGES += system/core-os
REQUIRED_PACKAGES += shell/bash
REQUIRED_PACKAGES += shell/ksh93
REQUIRED_PACKAGES += runtime/erlang

