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
COMPILER= gcc
BUILD_BITS= 64_and_32
include ../../make-rules/shared-macros.mk

PATH=$(dir $(CC)):$(JAVA_HOME)/bin:$(USRBINDIR):$(GNUBIN)

COMPONENT_NAME=		libidn
COMPONENT_VERSION=	1.34
COMPONENT_BAID=		49053
COMPONENT_ARCHIVE_HASH=	sha256:3719e2975f2fb28605df3479c380af2cf4ab4e919e1506527e4c7670afff6e3c
COMPONENT_BUGDB=	library/libidn
COMPONENT_ANITYA_ID=	1639

COMPONENT_NAME_1=	tldchk
COMPONENT_VERSION_1=	0.7
COMPONENT_ARCHIVE_1 =   tld-$(COMPONENT_VERSION_1).tar.gz
COMPONENT_ARCHIVE_HASH_1 = sha256:7423f48d15fb1377ee0050c3e1f22e8a91668c2f158afed57b8ead3fed908785
# berlios.de do not exists anymore tldchk was moved to https://github.com/gnuthor/tldchk
COMPONENT_ARCHIVE_URL_1 = https://download.sourceforge.net/sourceforge/tldchk.berlios/$(COMPONENT_ARCHIVE_1)

INSTALL_TARGET=
include $(WS_MAKE_RULES)/gnu-component.mk

LINT_FLAGS += -I$(PROTOUSRINCDIR)/idn
LINT_FLAGS += -DGNULIB_defined_stdint_types

COMPONENT_TEST_MASTER = \
	$(COMPONENT_TEST_RESULTS_DIR)/results-libidn.master

COMPONENT_TEST_TRANSFORMS += \
	'-n ' \
	'-e "/SKIP/p" ' \
	'-e "/PASS/p" ' \
	'-e "/FAIL/p" ' \
	'-e "/====/p" ' \
	'-e "/passed/p" '

CONFIGURE_ENV +=	INSTALL="$(INSTALL)"

CONFIGURE_OPTIONS  +=		--includedir=$(USRINCDIR)/idn
CONFIGURE_OPTIONS  +=		--localstatedir=$(VARDIR)
CONFIGURE_OPTIONS  +=		--infodir=$(CONFIGURE_INFODIR)
CONFIGURE_OPTIONS  +=		--enable-shared
CONFIGURE_OPTIONS  +=		--disable-static
CONFIGURE_OPTIONS  +=		--disable-csharp
CONFIGURE_OPTIONS  +=		--disable-rpath
CONFIGURE_OPTIONS  +=		--disable-valgrind-tests
CONFIGURE_OPTIONS  +=		--enable-tld
CONFIGURE_OPTIONS  +=		--enable-nls
CONFIGURE_OPTIONS  +=		--disable-gtk-doc
CONFIGURE_OPTIONS  +=		--enable-java
CONFIGURE_OPTIONS  +=		--with-libiconv-prefix=$(CONFIGURE_PREFIX)
CONFIGURE_OPTIONS  +=		--with-libintl-prefix=$(CONFIGURE_PREFIX)
CONFIGURE_OPTIONS  +=		--with-html-dir=$(CONFIGURE_PREFIX)/share/doc
CONFIGURE_OPTIONS  +=		--with-pic

IDNDOCDIR = $(PROTOUSRSHAREDOCDIR)/idn
HTMLDOCDIR = $(IDNDOCDIR)/html
HTMLDOCLIST = libidn-components.png libidn.html
DOCLIST = libidn-components.pdf libidn.pdf

# We must unpack the TLD database and touch the perl scripts in order
# to force re-generation of the TLD tables after augmenting them
COMPONENT_PRE_CONFIGURE_ACTION = \
	( cd $(SOURCE_DIR) ; \
	    $(CP) $(COMPONENT_DIR)/tld-0.7.tar.gz . ; \
	    $(GUNZIP) tld-0.7.tar.gz ; \
	    $(TAR) xvf tld-0.7.tar > /dev/null 2>&1 ; \
	    $(RM) tld-0.7.tar ; \
	    $(RM) java/libidn-1.19.jar ; \
	    $(RM) tld/no.tld tld/fr.tld ; \
	    $(CP) doc/tld/fr.tld tld/ ; \
	    $(CP) doc/tld/no.tld tld/ ; \
	    $(FIND) . -type d -exec chmod 0755 {} + ; \
	    $(FIND) ./tld -type f -name "*.tld" -exec chmod 0644 {} + ; \
	    $(FIND) ./tld -type f -name "*.tld" -exec touch -acm {} + ; \
	    $(FIND) ./tld/templates -type f -exec chmod 0644 {} + ; \
	    $(FIND) ./tld/templates -type f -exec touch -acm {} + ; \
	    $(FIND) ./lib -type f -name "*.pl" -exec touch -acm {} + ; \
	    $(FIND) ./lib -type f -name "*.pl" -exec chmod 0755 {} + )

install: $(INSTALL_32_and_64)
	$(MKDIR) $(HTMLDOCDIR) ; \
	list1='$(HTMLDOCLIST)' ; for f in $$list1; do \
	    $(INSTALL) -m 0644 $(COMPONENT_DIR)/$(COMPONENT_SRC)/doc/$$f \
	    $(HTMLDOCDIR)/ ; \
	    done
	list2='$(DOCLIST)' ; for f in $$list2; do \
	      $(INSTALL) -m 0644 $(COMPONENT_DIR)/$(COMPONENT_SRC)/doc/$$f \
	      $(IDNDOCDIR)/ ; \
	      done
	$(CP) -Rp $(COMPONENT_DIR)/$(COMPONENT_SRC)/doc/java \
	    $(IDNDOCDIR)/ ; \
	$(CP) -Rp $(COMPONENT_DIR)/$(COMPONENT_SRC)/tld \
	    $(IDNDOCDIR)/
	$(CP) -Rp $(PROTOUSRSHAREDIR)/locale/en@boldquot \
	    $(PROTOUSRSHAREDIR)/locale/en

