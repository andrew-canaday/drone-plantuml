#!/usr/bin/env bash
#===============================================================================
#
# make-util.sh: Utility functions for invoking GNU make
#
#===============================================================================
__DEFAULT_DEPFILE="$( mktemp )"
DEPFILE="${DEPFILE:-"${__DEFAULT_DEPFILE}"}"
export DEPFILE

# EOF

