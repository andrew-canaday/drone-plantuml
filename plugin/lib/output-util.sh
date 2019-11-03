#!/usr/bin/env bash
#===============================================================================
#
# output-util.sh: Utility functions for plugin output
#
#===============================================================================
function log_debug() {
    if [ "x${DEBUG}" == "xyes" ]; then
        printf "\e[00;02;32mDEBUG: \e[00;02m$@\e[00m\n" \
            "${__thisname}" "$@" >&2
    fi
}

function log_info() {
    printf "\e[00;32mINFO: \e[00m$@\e[00m\n" \
        "${__thisname}" "$@" >&2
}

function log_warn() {
    printf "\e[00;33mWARN: $@\e[00m\n" \
        "${__thisname}" "$@" >&2
}

function log_error() {
    printf "\e[00;31mERROR: $@\e[00m\n" \
        "${__thisname}" "$@" >&2
}

function err_bail() {
    log_error "$@"
    exit 1
}

# Print the value of a variable with name label.
# $1     - Variable name as a string
function print_var() {
    local var_name
    var_name="$1"
    if [ "x${DEBUG}" == "xyes" ]; then
        printf "\e[00;35mENV: \e[00;02;34m%s\e[00;02m=\"\e[00;02;33m%s\e[00;02m\"\e[00m\n" \
            "${var_name}" \
            "${!var_name}" >&2
    fi
}

# EOF

