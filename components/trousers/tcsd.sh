#! /usr/bin/sh
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
# Copyright (c) 2008, 2022, Oracle and/or its affiliates.
#

. /lib/svc/share/smf_include.sh

SYSTEM_DATA=/var/tpm/system/system.data
SYSTEM_DATA_AUTH="${SYSTEM_DATA}.auth"

# Fixing packaging issue when system.data is a symlink to system.data.auth which
# causes that the template is overwritten with any updates to system.data. To
# correct this state we need to remove the symlink (via pkg update) replace it
# with real file containing the user data (script here) and then fix the
# template (via pkg fix) which might be already modified.
function check_and_fix_templ {
	hash_orig="afa51c9ae39804d25703596f54856c0f2af70551a3dacfe9e79b552bfa2267c0"
	hash=$( digest -asha512_t -t256 $SYSTEM_DATA_AUTH )

	if [ $hash_orig != $hash ]; then
		echo "fixing pkg:/library/security/trousers"
		echo "system.data.auth hash = $hash"
		pkg fix pkg:/library/security/trousers
	fi
}

# SMF_FMRI is the name of the target service. This allows multiple instances 
# to use the same script.

if [ -z "$SMF_FMRI" ]; then
	echo "SMF framework variables are not initialized."
	exit $SMF_EXIT_ERR_NOSMF
fi

case "$1" in
'start')
	if [ ! -r "/dev/tpm" ]; then
		smf_method_exit $SMF_EXIT_TEMP_DISABLE no_supported_hardware \
			"No TPM device /dev/tpm found"
	fi

	# check if system.data is symlink which is incorrect
	if [ -L "$SYSTEM_DATA" ]; then
		echo "Error: The $SYSTEM_DATA is symlink, it requires" \
		    "manual intervention."
		exit $SMF_EXIT_ERR_FATAL
	fi

	# is it first run, then create configuration
	if [ ! -f "$SYSTEM_DATA" ]; then
		echo "File $SYSTEM_DATA does not exist, creating default."
		cp $SYSTEM_DATA_AUTH $SYSTEM_DATA
		chmod 600 $SYSTEM_DATA
		check_and_fix_templ
	fi

	echo /usr/lib/tcsd 
	TCSD_FOREGROUND=1 /usr/lib/tcsd &
	;;

# Attribute exec=':kill' in manifest tcsd.xml stops the tcsd daemon.

*)
	echo "Usage: $0 start"
	exit 1
	;;
esac

exit $SMF_EXIT_OK
