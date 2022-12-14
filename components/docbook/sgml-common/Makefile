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
# Copyright (c) 2016, 2021, Oracle and/or its affiliates.
#

BUILD_BITS=		64
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		sgml-common
COMPONENT_VERSION=	0.6.3
COMPONENT_PROJECT_URL=	http://www.w3.org/2003/entities/
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tgz
COMPONENT_ARCHIVE_HASH=	\
    sha256:7dc418c1d361123ffc5e45d61f1b97257940a8eb35d0bfbbc493381cc5b1f959
COMPONENT_ARCHIVE_URL= 	https://sourceware.org/ftp/docbook-tools/new-trials/SOURCES/$(COMPONENT_ARCHIVE)
COMPONENT_BUGDB=	utility/docbook
COMPONENT_ANITYA_ID=	227355

COMPONENT_BAID=		8404

TEST_TARGET = $(NO_TESTS)

include $(WS_MAKE_RULES)/common.mk

COMPONENT_PRE_CONFIGURE_ACTION = ($(CLONEY) $(SOURCE_DIR) $(@D))
COMPONENT_PREP_ACTION = \
        (cd $(@D) ; \
        aclocal -I . ; \
        autoconf ; \
        automake --add-missing --copy )

CONFIGURE_OPTIONS +=	--sysconfdir=$(ETCDIR)
CONFIGURE_OPTIONS +=	--with-docdir=$(USRSHAREDOCDIR)

# The /etc/sgml/catalog file is really generated by the
# svc:/application/desktop-cache/docbook-dtds-update:default service.
# We create (and deliver) an empty file so that if/when this package is
# removed, then that file will be too.
COMPONENT_POST_INSTALL_ACTION += $(MKDIR) $(PROTOETCDIR)/sgml/docbook ;
COMPONENT_POST_INSTALL_ACTION += $(TOUCH) $(PROTOETCDIR)/sgml/catalog ;

# The xmlcatalogs on the other hand are generated here, not by a service.
SGMLXMLCATALOG=$(ETCDIR)/sgml/docbook/xmlcatalog
XMLCATALOG=$(ETCDIR)/xml/catalog

# Create an empty XML catalog.
COMPONENT_POST_INSTALL_ACTION += $(MKDIR) $(PROTOETCDIR)/xml ;
COMPONENT_POST_INSTALL_ACTION += \
	$(USRBINDIR)/xmlcatalog --noout --create $(PROTO_DIR)$(XMLCATALOG) ;

# Now put the common DocBook entries in it
COMPONENT_POST_INSTALL_ACTION += \
	$(USRBINDIR)/xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//ENTITIES DocBook XML" \
		"file://$(SGMLXMLCATALOG)" $(PROTO_DIR)$(XMLCATALOG) ; \
	$(USRBINDIR)/xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//DTD DocBook XML" \
		"file://$(SGMLXMLCATALOG)" $(PROTO_DIR)$(XMLCATALOG) ; \
	$(USRBINDIR)/xmlcatalog --noout --add "delegatePublic" \
		"ISO 8879:1986" \
		"file://$(SGMLXMLCATALOG)" $(PROTO_DIR)$(XMLCATALOG) ; \
	$(USRBINDIR)/xmlcatalog --noout --add "delegateSystem" \
		"http://www.oasis-open.org/docbook/" \
		"file://$(SGMLXMLCATALOG)" $(PROTO_DIR)$(XMLCATALOG) ; \
	$(USRBINDIR)/xmlcatalog --noout --add "delegateURI" \
		"http://www.oasis-open.org/docbook/" \
		"file://$(SGMLXMLCATALOG)" $(PROTO_DIR)$(XMLCATALOG) ;

# Also create the common DocBook catalog
COMPONENT_POST_INSTALL_ACTION += \
	$(USRBINDIR)/xmlcatalog --noout --create \
		$(PROTO_DIR)$(SGMLXMLCATALOG) ;

# library/libxml2 provides the xmlcatalog command run above
REQUIRED_PACKAGES += library/libxml2
REQUIRED_PACKAGES += shell/ksh93
