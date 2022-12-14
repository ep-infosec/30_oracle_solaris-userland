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

BUILD_BITS =            64_and_32
# All components using gobject-introspection must be built with gcc as
# gobject-introspection does not produce correct results when using Studio.
COMPILER=gcc
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		libsecret
COMPONENT_VERSION=	0.20.4
COMPONENT_PROJECT_URL=	https://wiki.gnome.org/Projects/Libsecret
COMPONENT_ARCHIVE_HASH=	\
    sha256:325a4c54db320c406711bf2b55e5cb5b6c29823426aa82596a907595abb39d28
COMPONENT_BUGDB=        gnome/security
COMPONENT_ANITYA_ID=	13150

COMPONENT_BAID=		92084

include $(WS_MAKE_RULES)/gnome-component.mk

# Assumes GNU xgettext in PATH
CONFIGURE_ENV += PATH=$(GNUBIN):$(PATH)

# Required so that configure can find and use 64-bit version of config program.
CONFIGURE_ENV.64 += ac_cv_path_LIBGCRYPT_CONFIG=$(USRBINDIR64)/libgcrypt-config

CONFIGURE_OPTIONS += --disable-static
# Required for other components.
CONFIGURE_OPTIONS.32 += --disable-introspection
CONFIGURE_OPTIONS.64 += --enable-introspection
# Required for other components.
CONFIGURE_OPTIONS.32 += --disable-vala
CONFIGURE_OPTIONS.64 += --enable-vala

# Requires a reconf due to patch to configure.ac.
COMPONENT_PREP_ACTION += (cd $(@D); autoreconf -fiv);

COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-$(BITS).master
COMPONENT_TEST_ARGS =   -k -i
COMPONENT_TEST_TRANSFORMS += \
        '-n ' \
        '-e "/TOTAL:/p" ' \
        '-e "/SKIP:/p" ' \
        '-e "/PASS:/p" ' \
        '-e "/FAIL:/p" ' \
        '-e "/ERROR:/p" '


REQUIRED_PACKAGES += developer/documentation-tool/gtk-doc
REQUIRED_PACKAGES += developer/vala
REQUIRED_PACKAGES += library/desktop/gobject/gobject-introspection
REQUIRED_PACKAGES += library/glib2
REQUIRED_PACKAGES += library/perl-5/xml-parser
REQUIRED_PACKAGES += library/security/libgpg-error
REQUIRED_PACKAGES += $(PERL_PKG)
REQUIRED_PACKAGES += system/library/security/libgcrypt
