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
# Copyright (c) 2015, 2022, Oracle and/or its affiliates.
#

# This is a collection of Makefile lines needed for building PHP extensions
# outside of the PHP source tree.  It is named for the "phpize" script, which
# is the main deviation from the standard configure-make-install cycle.
# This file should handle everything necessary for an extension whose upstream
# expects the user to run "phpize" in order to create ./configure.

# Extension builds rely on installed versions of the PHP interpreters to
# access phpize and php-config.
# If the interpreters are being revved then look for commented out lines
# below to switch the extension builds to use interpreters in the build tree.

# xdebug is a good example of building an extension.

$(BUILD_DIR)/$(MACH64)-7.4/.configured: UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.configured: BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.configured: UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.configured: BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.configured: UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.configured: BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.built:      UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.built:      BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.built:      UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.built:      BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.built:      UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.built:      BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.installed:  UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.installed:  BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.installed:  UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.installed:  BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.installed:  UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.installed:  BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.tested:	UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.tested:	BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.tested:	UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.tested:	BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.tested:	UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.tested:	BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.tested-and-compared: UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.tested-and-compared: BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.tested-and-compared: UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.tested-and-compared: BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.tested-and-compared: UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.tested-and-compared: BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.system-tested: UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.system-tested: BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.system-tested: UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.system-tested: BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.system-tested: UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.system-tested: BITS=64

$(BUILD_DIR)/$(MACH64)-7.4/.system-tested-and-compared: UL_PHP_MINOR_VERSION=7.4
$(BUILD_DIR)/$(MACH64)-7.4/.system-tested-and-compared: BITS=64
$(BUILD_DIR)/$(MACH64)-8.0/.system-tested-and-compared: UL_PHP_MINOR_VERSION=8.0
$(BUILD_DIR)/$(MACH64)-8.0/.system-tested-and-compared: BITS=64
$(BUILD_DIR)/$(MACH64)-8.1/.system-tested-and-compared: UL_PHP_MINOR_VERSION=8.1
$(BUILD_DIR)/$(MACH64)-8.1/.system-tested-and-compared: BITS=64

CONFIGURE_64 = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.configured)
BUILD_64     = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.built)
INSTALL_64   = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.installed)

# determine the type of tests we want to run.
ifeq ($(strip $(wildcard $(COMPONENT_TEST_RESULTS_DIR)/results-*.master)),)
TEST_64      = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.tested)
else
TEST_64      = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.tested-and-compared)
endif

ifeq ($(strip $(wildcard $(COMPONENT_TEST_RESULTS_DIR)/results-*.master)),)
SYSTEM_TEST_64 = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.system-tested)
else
SYSTEM_TEST_64 = $(PHP_VERSIONS:%=$(BUILD_DIR)/$(MACH64)-%/.system-tested-and-compared)
endif

PHP_VERSION_NODOT = $(subst .,,$(UL_PHP_MINOR_VERSION))
PHP_HOME = $(PHP_TOP_DIR)/php$(PHP_VERSION_NODOT)

# Build extensions against source tree versions of the interpreters and
# not against installed interpreters.

$(BUILD_DIR)/$(MACH64)-7.4/.configured: \
	$(PHP_TOP_DIR)/php74/build/$(MACH64)/.installed

$(BUILD_DIR)/$(MACH64)-8.0/.configured: \
	$(PHP_TOP_DIR)/php80/build/$(MACH64)/.installed

$(BUILD_DIR)/$(MACH64)-8.1/.configured: \
	$(PHP_TOP_DIR)/php81/build/$(MACH64)/.installed

$(PHP_TOP_DIR)/php74/build/$(MACH64)/.installed \
$(PHP_TOP_DIR)/php80/build/$(MACH64)/.installed \
$(PHP_TOP_DIR)/php81/build/$(MACH64)/.installed: 
	cd $(PHP_HOME) ; $(GMAKE) install ;

COMPONENT_PRE_CONFIGURE_ACTION += \
	$(GSED) -e "s|^builddir=.*|builddir=$(@D)|" \
		< $(PHP_HOME)/proto-scripts/phpize-proto \
		> $(@D)/phpize-proto; \
	chmod +x $(@D)/phpize-proto;

# .tgz files from pecl contain this file
CLEAN_PATHS += package.xml

# The phpize script tries to copy some files into here, failing if the directory
# doesn't exist.
COMPONENT_PRE_CONFIGURE_ACTION += mkdir $(@D)/build;

# phpize generates configure where it is run.
COMPONENT_PRE_CONFIGURE_ACTION += $(CLONEY) $(SOURCE_DIR) $(@D) ;
CONFIGURE_SCRIPT = $(@D)/configure
COMPONENT_PRE_CONFIGURE_ACTION += cd $(@D) ; $(@D)/phpize-proto;

PROTOUSRPHPVERDIR = $(PHP_HOME)/build/prototype/$(MACH)/$(CONFIGURE_PREFIX)
# Change PHP_EXECUTABLE so tests can run.
COMPONENT_PRE_CONFIGURE_ACTION += \
	$(GSED) -i -e "s@^PHP_EXECUTABLE=.*@PHP_EXECUTABLE=$(PROTOUSRPHPVERDIR)/bin/php@" \
		$(CONFIGURE_SCRIPT) ;

COMPONENT_PRE_CONFIGURE_ACTION += \
    cp $(PHP_HOME)/proto-scripts/php-config-proto $(@D) ;
CONFIGURE_OPTIONS += --with-php-config=$(@D)/php-config-proto
