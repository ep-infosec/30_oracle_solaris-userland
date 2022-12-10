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
# Copyright (c) 2010, 2021, Oracle and/or its affiliates.
#

GIT =		/usr/bin/git

#
# Anything that we pull from a GIT repo must have a GIT_REPO{_[0-9]+} and
# GIT_COMMIT_ID{_[0-9]+} to match.
#

GIT_SUFFIXES = $(subst GIT_REPO_,, $(filter GIT_REPO_%, $(.VARIABLES)))

# Templates for git variables and rules.  We separate the variable assignments
# from the rules so that all the variable assignments are given a chance to
# complete before those variables are used in targets or prerequisites, where
# they'll be expanded immediately.
define git-variables
ifdef GIT_REPO$(1)
ifeq ($(strip $(or $(GIT_COMMIT_ID$(1)),$(GIT_BRANCH$(1)))),)
  $$(error GIT_COMMIT_ID$(1) or GIT_BRANCH$(1) must be defined)
endif

ifdef GIT_BRANCH$(1)
  GIT_BRANCH_ARG$(1) = -b $$(GIT_BRANCH$(1))
  $$(info GIT_BRANCH should only be used for testing, not committed to the gate)
endif

# If the label is not already defined (including to empty), set it to the version.
COMPONENT_LABEL$(1) ?= $$(COMPONENT_VERSION$(1))
# The source directory is <name>-(<label>|<version>)[-<branch>][-<commit>].
COMPONENT_SRC$(1) ?= $$(COMPONENT_NAME$(1))$$(COMPONENT_LABEL$(1):%=-%)$$(GIT_BRANCH$(1):%=-%)$$(GIT_COMMIT_ID$(1):%=-%)
COMPONENT_ARCHIVE$(1) ?= $$(COMPONENT_SRC$(1)).tar.gz
COMPONENT_ARCHIVE_SRC$(1) = git

CLEAN_PATHS += $$(COMPONENT_SRC$(1))
CLOBBER_PATHS += $$(COMPONENT_ARCHIVE$(1))
SOURCE_DIR$(1) = $$(COMPONENT_DIR)/$(COMPONENT_SRC$(1))
endif
endef

define git-rules
ifdef GIT_REPO$(1)
download::	$$(USERLAND_ARCHIVES)$$(COMPONENT_ARCHIVE$(1))

# First attempt to download a cached archive of the SCM repo at the proper
# changeset ID. If that fails, create an archive by cloning the SCM repo,
# updating to the selected changeset, archiving that directory, and cleaning up
# when complete.
#
# GIT CLONE ARGS
# A shallow clone (--depth=1) to git clone takes only the top level (named)
# commits on any branches or tags and can cause use of other commit IDs to
# fail.  As such, it should never be used here as it can make it impossible to
# reliably reproduce archives created from the result since git clone (unlike
# mercurial) currently has no way of cloning to a specific commit id.
$$(USERLAND_ARCHIVES)$$(COMPONENT_ARCHIVE$(1)):	$(MAKEFILE_PREREQ)
	$$(FETCH) --file $$@ \
		$$(GIT_HASH$(1):%=--hash %) || \
		( \
	$$(FETCH) --file $$@ \
		$$(COMPONENT_ARCHIVE_URL$(1):%=--url %) || \
	(TMP_REPO=$$$$(mktemp --directory) && \
	$(GIT) clone $$(GIT_REPO$(1)) $$(GIT_BRANCH_ARG$(1)) $$$${TMP_REPO} && \
	(cd $$$${TMP_REPO} ; \
		$(GIT) config tar.tar.bz2.command "bzip2 -c"; \
		$(GIT) config tar.tar.xz.command "xz -c"; \
		$(GIT) archive \
		--format $(subst $(COMPONENT_SRC$(1)).,,$(COMPONENT_ARCHIVE$(1))) \
		--prefix $$(COMPONENT_SRC$(1))/ \
		$$(or $$(GIT_COMMIT_ID$(1)),$$(GIT_BRANCH$(1)))) > $$@ && \
	$(RM) -r $$$${TMP_REPO} ) && \
	( GIT_HASH=$$$$(digest -a sha256 $$@) && \
	$(GSED) -i \
		-e "s/\(GIT_HASH$(1)[[:space:]]*=[[:space:]]*\).*/\1sha256:$$$${GIT_HASH}/" \
		Makefile )) && \
	$(TOUCH) $$@


REQUIRED_PACKAGES += developer/versioning/git

endif
endef

# Evaluate the variable assignments immediately
$(eval $(call git-variables,))
$(foreach suffix, $(GIT_SUFFIXES), $(eval $(call git-variables,_$(suffix))))

# Put the rule evaluations in a variable for deferred evaluation.
define eval-git-rules
$(eval $(call git-rules,))
$(foreach suffix, $(GIT_SUFFIXES), $(eval $(call git-rules,_$(suffix))))
endef
