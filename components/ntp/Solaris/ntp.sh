#!/sbin/sh
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
# Copyright (c) 2009, 2022, Oracle and/or its affiliates.
#

# Standard prolog
#
. /lib/svc/share/smf_include.sh

if [ -z $SMF_FMRI ]; then
        echo "SMF framework variables are not initialized."
        exit $SMF_EXIT_ERR_NOSMF
fi

FMRI_DEFAULT='svc:/network/ntp:default'
FMRI_MONITOR='svc:/network/ntp:monitor'
FMRI_PTP='svc:/network/ptp:default'
# The redirect file must be in /sysem/volatile
REDIRECT="/system/volatile/ntp_redirect.conf"

if [ "$SMF_FMRI" = "$FMRI_DEFAULT" ]; then
	monitor_enabled=`svcprop -c -p general/enabled $FMRI_MONITOR`
	if [ "$monitor_enabled" = "true" ]; then
		echo "Error: Both $SMF_FMRI and $FMRI_MONITOR may not be" \
	       	    " enabled at the same time."
		exit $SMF_EXIT_ERR_CONFIG
	fi
	ptp_enabled=`svcprop -c -p general/enabled $FMRI_PTP 2>&1`
	if [ "$ptp_enabled" = "true" ]; then
		echo "Error: Both $SMF_FMRI and $FMRI_PTP may not be" \
	       	    " enabled at the same time."
		exit $SMF_EXIT_ERR_CONFIG
	fi
fi
if [ "$SMF_FMRI" = "$FMRI_MONITOR" ]; then
	default_enabled=`svcprop -c -p general/enabled $FMRI_DEFAULT`
	if [ "$default_enabled" = "true" ]; then
		echo "Error: Both $SMF_FMRI and $FMRI_DEFAULT may not be" \
	       	    " enabled at the same time."
		exit $SMF_EXIT_ERR_CONFIG
	fi
fi

# Because we sometimes want to specify configuration info, we put the
# lines we want into a special file, and then add an includefile back to the
# original file.

# Get rid of stale redirect file.
if [ -f $REDIRECT ]; then
	rm -f $REDIRECT
fi
# Create empty redirect file
(umask 077 ; echo '# NTP Configuration file' > $REDIRECT )

#
# Is NTP configured?
#
conffile=`svcprop -c -p config/configfile $SMF_FMRI`
if [ ! -f $conffile ]; then
	echo "Error: Configuration file $conffile not found." \
	    "  See ntpd(1M)."
	exit $SMF_EXIT_ERR_CONFIG
fi

# Disable globbing to prevent privilege escalations by users authorized
# to set property values for the NTP service.
set -f

# Do we want to run without setting the clock? If not and we don't have
# the priv to set the clock, exit. If so, remove the priv and
# continue on. Set env variable to tell ntpd to ignore EPERM errors.
val=`svcprop -c -p config/disable_local_time_adjustment $SMF_FMRI`
if [ "$val" = "true" ]; then
       	export IGNORE_SYS_TIME_ERROR=1
	ppriv -s EIP-sys_time $$
else
	ppriv -q sys_time
	if (($? > 0)); then
		echo "Error: Insufficient privilege to adjust the system clock." \
	    	" Set the disable_local_time_adjustment property to run anyway."
		exit $SMF_EXIT_ERR_CONFIG
	fi
fi

# If we are in monitor mode, don't try to adjust the clock
if [ "$SMF_FMRI" = "$FMRI_MONITOR" ]; then
	echo disable ntp >> $REDIRECT
	# Take away the priv so they can not re-enable it
       	export IGNORE_SYS_TIME_ERROR=1
	ppriv -s EIP-sys_time $$
fi

# Redirect the configuration file
echo includefile $conffile >> $REDIRECT

#
# Build the command line flags
#
shift $#
set -- -c $REDIRECT
set -- "$@" --pidfile /var/run/ntp.pid
# We allow a step larger than the panic value of 17 minutes only
# once when ntpd starts up. If always_allow_large_step is true,
# then we allow this each time ntpd starts. Otherwise, we allow
# it only the very first time ntpd starts after a boot. We
# check that by making ntpd write its pid to a file in /var/run.

val=`svcprop -c -p config/always_allow_large_step $SMF_FMRI`
if [ "$val" = "true" ] || \
    [ ! -f /var/run/ntp.pid ]; then
        set -- "$@" --panicgate
fi

# Auth was off by default in xntpd now the default is on. Better have a way
# to turn it off again. Also check for the obsolete "authentication" keyword.
val=`svcprop -c -p config/no_auth_required $SMF_FMRI`
if [ ! "$val" = "true" ]; then
        val=`/usr/bin/nawk '/^[ \t]*#/{next}
            /^[ \t]*authentication[ \t]+no/ {
                printf("true", $2)
                next } ' $conffile`
fi
[ "$val" = "true" ] && set -- "$@" --authnoreq

# Set up logging if requested.
logfile=`svcprop -c -p config/logfile $SMF_FMRI`
val=`svcprop -c -p config/verbose_logging $SMF_FMRI`
[ "$val" = "true" ] && [ -n "$logfile" ]  && set -- "$@" --logfile $logfile

# Register with mDNS.
val=`svcprop -c -p config/mdnsregister $SMF_FMRI`
mdns=`svcprop -c -p general/enabled svc:/network/dns/multicast:default`
[ "$val" = "true" ] && [ "$mdns" = "true" ] && set -- "$@" --mdns

# We used to support the slewalways keyword, but that was a Sun thing
# and not in V4. Look for "slewalways yes" and set the new slew option.
slew_always=`svcprop -c -p config/slew_always $SMF_FMRI`
if [ ! "$slew_always" = "true" ]; then
	slew_always=`/usr/bin/nawk '/^[ \t]*#/{next}
	    /^[ \t]*slewalways[ \t]+yes/ {
        	printf("true", $2)
        	next } ' $conffile`
fi
[ "$slew_always" = "true" ] && set -- "$@" --slew

# Set up debugging.
deb=`svcprop -c -p config/debuglevel $SMF_FMRI`

# If slew_always is set to true, then the large offset after a reboot
# might take a very long time to correct the clock. Optionally allow
# a step once after a reboot if slew_always is set when allow_step_at_boot
# is also set.
val=`svcprop -c -p config/allow_step_at_boot $SMF_FMRI`
if [ "$val" = "true" ] && [ "$slew_always" = "true" ] && \
    [ ! -f /var/run/ntp.pid ]; then
	set -- "$@" --force-step-once
fi

# It is possible to make the system unbootable in certain configurations
# if the date is set to after the epoch rollover in Feb. 2038. This is
# not likely but if protection is required we will prevent NTP from setting
# any date in 2038.
val=`svcprop -c -p config/no_2038 $SMF_FMRI`
if [ "$val" = "true" ]; then
	NTP_NO_2038=1
	export NTP_NO_2038
fi

# Start the daemon. If debugging is requested, put it in the background,
# since it won't do it on it's own.
if [ "$deb" -gt 0 ]; then
	/usr/lib/inet/ntpd "$@" --set-debug-level=$deb >/var/ntp/ntp.debug &
else
	/usr/lib/inet/ntpd "$@"
fi

# Now, wait for the first sync, if requested.
val=`svcprop -c -p config/wait_for_sync $SMF_FMRI`
[ "$val" = "true" ] && /usr/lib/inet/ntp-wait

exit $SMF_EXIT_OK
