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

COMPONENT_NAME=		iftop
COMPONENT_VERSION=	0.17
COMPONENT_PROJECT_URL=	http://www.ex-parrot.com/~pdw/iftop/
COMPONENT_ARCHIVE_HASH=	\
    sha256:d032547c708307159ff5fd0df23ebd3cfa7799c31536fa0aea1820318a8e0eac
COMPONENT_ARCHIVE_URL=	http://www.ex-parrot.com/~pdw/iftop/download/$(COMPONENT_ARCHIVE)
COMPONENT_ANITYA_ID=	1366

COMPONENT_BAID=		8203

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

COMPONENT_PRE_CONFIGURE_ACTION = \
    ($(CLONEY) $(SOURCE_DIR) $(@D))

PATCH_LEVEL=	0

# without this we bus error on sparc. sadly I don't see any patches
# that might relate from the upstream (though maybe that's really
# "happily", as this is simpler)
studio_ALIGN.sparc.64=	-xmemalign=1i

IFTOP_LIBDIR=	$(USRGNUDIR)/lib
LDFLAGS +=	-L$(IFTOP_LIBDIR) -R$(IFTOP_LIBDIR)
CPPFLAGS +=	-I$(USRGNUDIR)/include -I$(USRINCDIR)/ncurses

REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += system/library/libpcap
REQUIRED_PACKAGES += system/library/math
