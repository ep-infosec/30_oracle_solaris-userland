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
include ../../../make-rules/shared-macros.mk

COMPONENT_NAME=		foomatic-filters-ppds
COMPONENT_VERSION=	20080818
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.gz
COMPONENT_ARCHIVE_HASH=	\
    sha256:906e1ea87ddb7cf0fd27f21c1b077f87644b402f1b7a66d4049a72b68e5eeb05
COMPONENT_ARCHIVE_URL=	$(EXTERNAL_ARCHIVE_MIRROR)/$(COMPONENT_ARCHIVE)
COMPONENT_PROJECT_URL=	http://www.linuxfoundation.org/collaborate/workgroups/openprinting/database/foomatic/
COMPONENT_BUGDB=	utility/foomatic

COMPONENT_BAID=		1633

include $(WS_MAKE_RULES)/prep.mk
include $(WS_MAKE_RULES)/ips.mk

CACHE_FILE=$(PROTOUSRLIBDIR)/lp/caches/SUNWfoomatic.cache

$(SOURCE_DIR)/.built: $(SOURCE_DIR)/.prep $(COMPONENT_DIR)/nolicense $(COMPONENT_DIR)/supportedonly.sh
	$(MKDIR) $(BUILD_DIR)
	$(SHELL) $(COMPONENT_DIR)/supportedonly.sh $(BUILD_DIR) \
		$(SOURCE_DIR)/share/ppd $(CACHE_FILE) $(COMPONENT_DIR)/nolicense
	$(TOUCH) $@

# move tree of .ppd-s to proto and gzip it
$(SOURCE_DIR)/.installed: $(SOURCE_DIR)/.built
	$(MKDIR) $(PROTOUSRSHAREDIR)/ppd
	/usr/bin/find $(SOURCE_DIR)/share/ppd -name "*.ppd" -exec gzip {} +
	$(CLONEY) $(SOURCE_DIR)/share/ppd $(PROTOUSRSHAREDIR)/ppd/SUNWfoomatic
	$(TOUCH) $@

ASLR_MODE = $(ASLR_NOT_APPLICABLE)

# common targets
build:	$(SOURCE_DIR)/.built

install:	$(SOURCE_DIR)/.installed

test:	$(NO_TESTS)

system-test:    $(NO_TESTS)

clean::
	$(RM) -r $(BUILD_DIR)

