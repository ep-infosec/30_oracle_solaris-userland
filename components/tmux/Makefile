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
# Copyright (c) 2013, 2021, Oracle and/or its affiliates.
#
BUILD_BITS= 64
# Use GCC until Studio supports large enums (23058232)
COMPILER=	gcc
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		tmux
COMPONENT_VERSION=	3.1c
IPS_COMPONENT_VERSION=	3.1.3
HUMAN_VERSION=		$(COMPONENT_VERSION)
COMPONENT_PROJECT_URL=	https://tmux.github.io/
COMPONENT_ARCHIVE_HASH=	\
    sha256:741fed668e711388cfb3d5f84f54b8e18d53ab3f59e2f065102773fafe8dc834
COMPONENT_ANITYA_ID=	4980

COMPONENT_ARCHIVE_URL=	https://github.com/tmux/tmux/releases/download/$(COMPONENT_VERSION)/$(COMPONENT_ARCHIVE)

COMPONENT_BAID=		88937


TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

CONFIGURE_ENV += LIBNCURSES_CFLAGS=-I$(USRINCDIR)/ncurses
CONFIGURE_ENV += LIBNCURSES_LIBS="-L$(USRLIBDIR64) -lncurses"

REQUIRED_PACKAGES += library/libevent
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += shell/ksh93
