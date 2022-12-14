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

BUILD_BITS= 64
COMPILER= gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		pidgin
COMPONENT_VERSION=	2.13.0
COMPONENT_PROJECT_URL=	https://www.pidgin.im
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_HASH= \
    sha256:21441733b4019241529e556327c36d36b0bb98aef5ec8e47ce7a6a1947fde344
COMPONENT_ARCHIVE_URL=	https://downloads.sourceforge.net/$(COMPONENT_NAME)/$(COMPONENT_ARCHIVE)
COMPONENT_SIG_URL=	$(COMPONENT_ARCHIVE_URL).asc
COMPONENT_ANITYA_ID=	3636

COMPONENT_BAID=		74065

# Use explicit version of Python
PYTHON_VERSION = 3.7

TEST_TARGET= $(NO_TESTS)
include $(WS_MAKE_RULES)/common.mk

# Need to pick up the GNU version of xgettext.
PATH=$(GNUBIN):$(USRBINDIR)

CFLAGS +=		-DG_IMPLEMENT_INLINES -DG_HAVE_ISO_VARARGS

COMPONENT_PREP_ACTION = \
	(cd $(@D) ; \
	glib-gettextize -f ; \
	libtoolize --force ; \
	intltoolize --force --copy --automake ; \
	aclocal -I . ; \
	autoheader ; \
	automake -a -c -f ; \
	autoconf )

# Needed to get libpurple to link properly.
LIBS += -lresolv
CONFIGURE_ENV +=	LIBS="$(LIBS)"

CONFIGURE_ENV += "ac_cv_path_perlpath=$(PERL)"
CONFIGURE_ENV +=	PERL="$(PERL)"

CONFIGURE_OPTIONS +=	--enable-cyrus-sasl
CONFIGURE_OPTIONS +=	--enable-nss
CONFIGURE_OPTIONS +=	--with-nspr-includes=/usr/include/mps
CONFIGURE_OPTIONS +=	--with-nspr-libs=/usr/lib/mps/64
CONFIGURE_OPTIONS +=	--with-nss-includes=/usr/include/mps
CONFIGURE_OPTIONS +=	--with-nss-libs=/usr/lib/mps/64
CONFIGURE_OPTIONS +=	--disable-gnutls
CONFIGURE_OPTIONS +=	--enable-gnome-keyring
CONFIGURE_OPTIONS +=	--disable-gevolution
CONFIGURE_OPTIONS +=	--enable-cap
CONFIGURE_OPTIONS +=	--disable-meanwhile
CONFIGURE_OPTIONS +=	--disable-nm
CONFIGURE_OPTIONS +=	--enable-consoleui
CONFIGURE_OPTIONS +=	--with-ncurses-headers=/usr/include/ncurses
CONFIGURE_OPTIONS +=	--disable-vv
CONFIGURE_OPTIONS +=	--with-system-ssl-certs=/etc/certs
CONFIGURE_OPTIONS +=	--with-python=$(PYTHON)

# We have two implementations of libcurses in Solaris. finch needs to use the
# ncurses one. The curses implementations in turn, use libpanel, but the
# ncurses one is under /usr/gnu/lib. To make sure that it correctly uses that
# one, and not the one under /usr/lib, we need to remove all occurrences of
# -L/usr/lib/$(MACH64), -L/usr/lib, -L/lib/$(MACH64) and -L/lib from all
# Makefiles.
COMPONENT_POST_CONFIGURE_ACTION = \
	(cd $(@D) ; \
	mlist=`/usr/bin/find . -name 'Makefile'` ; \
	echo $$mlist ; \
	for f in $$mlist ; do \
		$(GSED) -i \
			-e 's|-L/usr/lib/$(MACH64) ||g' \
			-e 's|-L/usr/lib ||g' \
			-e 's|-L/lib/$(MACH64) ||g' \
			-e 's|-L/lib ||g' \
			$$f ; \
        done)

# Always show the build and link lines for easier debugging.
COMPONENT_BUILD_ARGS +=	V=1

# Prevent build problems with package_revision.h with "hg id ..." in the main
# pidgin Makefile, if the user has color.mode=terminfo in their ~/.hgrc file.
COMPONENT_BUILD_ARGS += HGPLAIN=
COMPONENT_BUILD_ARGS += HGRCPATH=/dev/null

REQUIRED_PACKAGES += communication/im/pidgin-gnome-keyring
REQUIRED_PACKAGES += database/sqlite-3
REQUIRED_PACKAGES += library/desktop/atk
REQUIRED_PACKAGES += library/desktop/cairo
REQUIRED_PACKAGES += library/desktop/gdk-pixbuf
REQUIRED_PACKAGES += library/desktop/gstreamer-1
REQUIRED_PACKAGES += library/desktop/gstreamer-1/gst-plugins-good
REQUIRED_PACKAGES += library/desktop/gtk2
REQUIRED_PACKAGES += library/desktop/gtkspell
REQUIRED_PACKAGES += library/desktop/pango
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/libidn
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += library/ncurses
REQUIRED_PACKAGES += library/nspr
REQUIRED_PACKAGES += library/perl-5/xml-parser
REQUIRED_PACKAGES += library/python/dbus-python-37
REQUIRED_PACKAGES += library/security/nss
REQUIRED_PACKAGES += $(PERL_PKG)
REQUIRED_PACKAGES += runtime/python-37
REQUIRED_PACKAGES += runtime/tcl-8
REQUIRED_PACKAGES += runtime/tk-8
REQUIRED_PACKAGES += shell/ksh93
REQUIRED_PACKAGES += system/library/gcc/gcc-c-runtime
REQUIRED_PACKAGES += system/library/libdbus
REQUIRED_PACKAGES += system/library/libdbus-glib
REQUIRED_PACKAGES += system/library/math
REQUIRED_PACKAGES += system/library/security/libsasl2
REQUIRED_PACKAGES += system/network/avahi
REQUIRED_PACKAGES += system/network/avahi/gui
REQUIRED_PACKAGES += x11/library/libice
REQUIRED_PACKAGES += x11/library/libsm
REQUIRED_PACKAGES += x11/library/libx11
REQUIRED_PACKAGES += x11/library/libxext
REQUIRED_PACKAGES += x11/library/libxscrnsaver
