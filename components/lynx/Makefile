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
# Copyright (c) 2014, 2021, Oracle and/or its affiliates.
#
BUILD_BITS= 64
include ../../make-rules/shared-macros.mk

COMPONENT_NAME=		lynx
COMPONENT_VERSION=	2.8.8
COMPONENT_PROJECT_URL=	https://lynx.browser.org/
COMPONENT_SRC=		$(COMPONENT_NAME)2-8-8
COMPONENT_ARCHIVE=	$(COMPONENT_NAME)$(COMPONENT_VERSION)rel.2.tar.bz2
COMPONENT_ARCHIVE_HASH=	\
    sha256:6980e75cf0d677fd52c116e2e0dfd3884e360970c88c8356a114338500d5bee7
COMPONENT_ARCHIVE_URL=	\
    https://invisible-mirror.net/archives/lynx/tarballs/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).asc
COMPONENT_ANITYA_ID=	1863

COMPONENT_BAID=		22182

SYSTEM_TEST_TARGET= $(SYSTEM_TEST_64)

# Unit tests require a network access to download test webpages.
$(SKIP_TEST_AT_TOP_LEVEL)

include $(WS_MAKE_RULES)/common.mk

# Needed to successfully find lynx.pot.
COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))

CFLAGS +=	-I$(USRINCDIR)/ncurses
CFLAGS += $(XPG6MODE)
studio_C99MODE = $(studio_C99_ENABLE) 

CONFIGURE_OPTIONS +=	--enable-nls
CONFIGURE_OPTIONS +=	--enable-japanese-utf8
CONFIGURE_OPTIONS +=	--enable-widec
CONFIGURE_OPTIONS +=	--sysconfdir=$(ETCDIR)/lynx
CONFIGURE_OPTIONS +=	--with-ssl
CONFIGURE_OPTIONS +=	--with-screen=ncurses

# Use the HTML and CSS styling external test suite as referenced at
# http://www.w3.org/2005/MWI/Tests/. Use the US proxy to avoid HTTP 401 errors.
COMPONENT_TEST_CMD = $(@D)/src/lynx
COMPONENT_TEST_ARGS = -dump \
	http://www.cameronmoll.com/articles/mobile/mkp/pg1.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg2.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg3.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg4.html
COMPONENT_TEST_TARGETS =

COMPONENT_SYSTEM_TEST_DIR =
COMPONENT_SYSTEM_TEST_CMD =		$(USRBINDIR)/lynx
COMPONENT_SYSTEM_TEST_ARGS =		-dump \
	http://www.cameronmoll.com/articles/mobile/mkp/pg1.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg2.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg3.html \
	http://www.cameronmoll.com/articles/mobile/mkp/pg4.html
COMPONENT_SYSTEM_TEST_TARGETS =

REQUIRED_PACKAGES += library/libidn
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/security/openssl
REQUIRED_PACKAGES += library/security/openssl/openssl-fips-140
