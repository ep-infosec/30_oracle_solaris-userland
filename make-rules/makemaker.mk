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
# Copyright (c) 2011, 2022, Oracle and/or its affiliates.
#

# makemaker.mk is used to build, install, test perl modules for
# each version of perl.
# Packaging these multiple versions is still handled by ips.mk.
# Look under perl_modules for examples of usage.

# Multiple versions of perl processing is achieved by listing targets
# for each version and adding BUILD_64/INSTALL_64 targets below.
# Example:
# $(BUILD_DIR)/$(MACH64)-5.24/.configured: PERL_VERSION=5.24
# BUILD_64 +=     $(BUILD_DIR)/$(MACH64)-5.24/.built
# INSTALL_64 +=   $(BUILD_DIR)/$(MACH64)-5.24/.installed
# TEST_64 +=      $(BUILD_DIR)/$(MACH64)-5.24/.tested
# TEST_64 +=      $(BUILD_DIR)/$(MACH64)-5.24/.tested-and-compared
# and so on.

COMMON_PERL_ENV += MAKE=$(GMAKE)
COMMON_PERL_ENV += PATH=$(dir $(CC)):$(SPRO_VROOT)/bin:$(PATH)
COMMON_PERL_ENV += LANG=""
COMMON_PERL_ENV += CC="$(CC)"

# These are filled later by calling define-perl-targets
BUILD_64 =
INSTALL_64 =
TEST_64 =
SYSTEM_TEST_64 =

define define-perl-targets
ifneq ($$(findstring $(1),$(PERL_VERSIONS)),)
$(BUILD_DIR)/$(MACH64)-$(1)/.configured: PERL_VERSION=$(1)
$(BUILD_DIR)/$(MACH64)-$(1)/.tested: PERL_VERSION=$(1)
$(BUILD_DIR)/$(MACH64)-$(1)/.tested-and-compared: PERL_VERSION=$(1)
$(BUILD_DIR)/$(MACH64)-$(1)/.system-tested: PERL_VERSION=$(1)
$(BUILD_DIR)/$(MACH64)-$(1)/.system-tested-and-compared: PERL_VERSION=$(1)
BUILD_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.built
INSTALL_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.installed
ifeq ($$(strip $$(wildcard $(COMPONENT_TEST_RESULTS_DIR)/results*.master)),)
TEST_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.tested
SYSTEM_TEST_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.system-tested
else
TEST_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.tested-and-compared
SYSTEM_TEST_64 +=	$(BUILD_DIR)/$(MACH64)-$(1)/.system-tested-and-compared
endif
endif
endef

$(foreach perlver, $(PERL_VERSIONS), \
	$(eval $(call define-perl-targets,$(perlver))) \
)

# Map each $(PERL_VERSIONS) to REQUIRED_PACKAGES needed
PERL_REQUIRED_PACKAGES_5.32 += runtime/perl-532
PERL_REQUIRED_PACKAGES_5.36 += runtime/perl-536


CONFIGURE_ENV += $(COMMON_PERL_ENV)
CONFIGURE_ENV += PERL="$(PERL)"
$(BUILD_DIR)/%/.configured:	$(SOURCE_DIR)/.prep
	($(RM) -r $(@D) ; $(MKDIR) $(@D))
	$(CLONEY) $(SOURCE_DIR) $(@D)
	$(COMPONENT_PRE_CONFIGURE_ACTION)
	(cd $(@D) ; $(CONFIGURE_ENV) $(PERL) $(PERL_FLAGS) \
				Makefile.PL $(CONFIGURE_OPTIONS))
	$(COMPONENT_POST_CONFIGURE_ACTION)
	$(TOUCH) $@


COMPONENT_BUILD_ENV +=	$(COMMON_PERL_ENV)
$(BUILD_DIR)/%/.built:	$(BUILD_DIR)/%/.configured
	$(COMPONENT_PRE_BUILD_ACTION)
	(cd $(@D) ; $(ENV) $(COMPONENT_BUILD_ENV) \
		$(GMAKE) $(COMPONENT_BUILD_ARGS) $(COMPONENT_BUILD_TARGETS))
	$(COMPONENT_POST_BUILD_ACTION)
ifeq   ($(strip $(PARFAIT_BUILD)),yes)
	-$(PARFAIT) -e all -W --baseline-out=$(@D)/parfait.baseline -z $(SOURCE_DIR) -o $(@D)/parfait.report $(@D)
endif
	$(TOUCH) $@


COMPONENT_INSTALL_ARGS +=	DESTDIR="$(PROTO_DIR)"
COMPONENT_INSTALL_TARGETS =	install_vendor
COMPONENT_INSTALL_ENV +=	$(COMMON_PERL_ENV)
$(BUILD_DIR)/%/.installed:	$(BUILD_DIR)/%/.built
	$(COMPONENT_PRE_INSTALL_ACTION)
	(cd $(@D) ; $(ENV) $(COMPONENT_INSTALL_ENV) $(GMAKE) \
			$(COMPONENT_INSTALL_ARGS) $(COMPONENT_INSTALL_TARGETS))
	$(COMPONENT_POST_INSTALL_ACTION)
	$(TOUCH) $@


# Define bit specific and Perl version specific filenames.
COMPONENT_TEST_BUILD_DIR = $(BUILD_DIR)/test/$(MACH$(BITS))-$(PERL_VERSION)
COMPONENT_TEST_MASTER = $(COMPONENT_TEST_RESULTS_DIR)/results-$(PERL_VERSION)-$(BITS).master
COMPONENT_TEST_OUTPUT = $(COMPONENT_TEST_BUILD_DIR)/test-$(PERL_VERSION)-$(BITS)-results
COMPONENT_TEST_DIFFS =  $(COMPONENT_TEST_BUILD_DIR)/test-$(PERL_VERSION)-$(BITS)-diffs
COMPONENT_TEST_SNAPSHOT = $(COMPONENT_TEST_BUILD_DIR)/results-$(PERL_VERSION)-$(BITS).snapshot
COMPONENT_TEST_TRANSFORM_CMD = $(COMPONENT_TEST_BUILD_DIR)/transform-$(PERL_VERSION)-$(BITS)-results

COMPONENT_TEST_TARGETS =	check
COMPONENT_TEST_ENV +=		$(COMMON_PERL_ENV)
COMPONENT_SYSTEM_TEST_TARGETS =	check
COMPONENT_SYSTEM_TEST_ENV +=	$(COMMON_PERL_ENV)

# Test the built source.  If the output file shows up in the environment or
# arguments, don't redirect stdout/stderr to it.
$(BUILD_DIR)/%/.tested-and-compared:    $(BUILD_DIR)/%/.built
	$(RM) -rf $(COMPONENT_TEST_BUILD_DIR)
	$(MKDIR) $(COMPONENT_TEST_BUILD_DIR)
	$(COMPONENT_PRE_TEST_ACTION)
	-(cd $(COMPONENT_TEST_DIR) ; \
		$(COMPONENT_TEST_ENV_CMD) $(COMPONENT_TEST_ENV) \
		$(COMPONENT_TEST_CMD) \
		$(COMPONENT_TEST_ARGS) $(COMPONENT_TEST_TARGETS)) \
		$(if $(findstring $(COMPONENT_TEST_OUTPUT),$(COMPONENT_TEST_ENV)$(COMPONENT_TEST_ARGS)),,&> $(COMPONENT_TEST_OUTPUT))
	$(COMPONENT_POST_TEST_ACTION)
	$(COMPONENT_TEST_CREATE_TRANSFORMS)
	$(COMPONENT_TEST_PERFORM_TRANSFORM)
	$(COMPONENT_TEST_COMPARE)
	$(COMPONENT_TEST_CLEANUP)
	$(TOUCH) $@

$(BUILD_DIR)/%/.tested:    $(BUILD_DIR)/%/.built
	$(COMPONENT_PRE_TEST_ACTION)
	(cd $(COMPONENT_TEST_DIR) ; \
		$(COMPONENT_TEST_ENV_CMD) $(COMPONENT_TEST_ENV) \
		$(COMPONENT_TEST_CMD) \
		$(COMPONENT_TEST_ARGS) $(COMPONENT_TEST_TARGETS))
	$(COMPONENT_POST_TEST_ACTION)
	$(COMPONENT_TEST_CLEANUP)
	$(TOUCH) $@

# Test the installed packages.  The targets above depend on .built which
# means $(CLONEY) has already run.  System-test needs cloning but not
# building; thus ideally, we would want to depend on .cloned here and below,
# but since we don't have that, we depend on .prep and run $(CLONEY) here.  If
# the output file shows up in the environment or arguments, don't redirect
# stdout/stderr to it.
$(BUILD_DIR)/%/.system-tested-and-compared:    $(SOURCE_DIR)/.prep
	$(RM) -rf $(COMPONENT_TEST_BUILD_DIR)
	$(MKDIR) $(COMPONENT_TEST_BUILD_DIR)
	$(CLONEY) $(SOURCE_DIR) $(@D)
	$(COMPONENT_PRE_SYSTEM_TEST_ACTION)
	-(cd $(COMPONENT_SYSTEM_TEST_DIR) ; \
		$(COMPONENT_SYSTEM_TEST_ENV_CMD) $(COMPONENT_SYSTEM_TEST_ENV) \
		$(COMPONENT_SYSTEM_TEST_CMD) \
		$(COMPONENT_SYSTEM_TEST_ARGS) $(COMPONENT_SYSTEM_TEST_TARGETS)) \
		$(if $(findstring $(COMPONENT_TEST_OUTPUT),$(COMPONENT_SYSTEM_TEST_ENV)$(COMPONENT_SYSTEM_TEST_ARGS)),,&> $(COMPONENT_TEST_OUTPUT))
	$(COMPONENT_POST_SYSTEM_TEST_ACTION)
	$(COMPONENT_TEST_CREATE_TRANSFORMS)
	$(COMPONENT_TEST_PERFORM_TRANSFORM)
	$(COMPONENT_TEST_COMPARE)
	$(COMPONENT_SYSTEM_TEST_CLEANUP)
	$(TOUCH) $@

$(BUILD_DIR)/%/.system-tested:    $(SOURCE_DIR)/.prep
	$(CLONEY) $(SOURCE_DIR) $(@D)
	$(COMPONENT_PRE_SYSTEM_TEST_ACTION)
	(cd $(COMPONENT_SYSTEM_TEST_DIR) ; \
		$(COMPONENT_SYSTEM_TEST_ENV_CMD) $(COMPONENT_SYSTEM_TEST_ENV) \
		$(COMPONENT_SYSTEM_TEST_CMD) \
		$(COMPONENT_SYSTEM_TEST_ARGS) $(COMPONENT_SYSTEM_TEST_TARGETS))
	$(COMPONENT_POST_SYSTEM_TEST_ACTION)
	$(COMPONENT_SYSTEM_TEST_CLEANUP)
	$(TOUCH) $@

ifeq   ($(strip $(PARFAIT_BUILD)),yes)
parfait: build
else
parfait:
	$(MAKE) PARFAIT_BUILD=yes parfait
endif

define set-perl-req-packages
TEST_PERL_REQ=$$(PERL_REQUIRED_PACKAGES_$(1))
ifeq ($$(strip $$(TEST_PERL_REQ)),)
$$(error variable PERL_REQUIRED_PACKAGES_$(1) is not defined)
endif
$$(eval REQUIRED_PACKAGES += $$(TEST_PERL_REQ))
endef

# PERL_VERSIONS can be modified in the Makefile so that component does not need
# to be compiled with all perl versions if needed
$(foreach p,$(PERL_VERSIONS),$(eval $(call set-perl-req-packages,$(p))))
