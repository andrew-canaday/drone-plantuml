#!/usr/bin/env bash
#===============================================================================
#
# drone-plantuml.sh: Main entrypoint for drone.io plantuml diagram plugin
#
#===============================================================================

# Basic context:
__thispath="${0}"
__thisdir="$( cd ${__thispath%/*} ; echo "${PWD}" )"
__thisname="${__thispath##*/}"
export __thisdir


#--------------------------------------------
# Globals/Defaults:
#--------------------------------------------

# HACK: get default and ensure proper formatting (i.e. no trailing '/'):
PU_ROOT="$( cd ${PU_ROOT:-"${PWD}"} ; echo "${PWD}" )"
PLANTUML="${PLANTUML:-"$( command -v plantuml )"}"

__DEFAULT_DEPFILE="$( mktemp )"
DEPFILE="${DEPFILE:-"${__DEFAULT_DEPFILE}"}"
export PLANTUML DEPFILE PU_ROOT

#--------------------------------------------
# Utilities:
#--------------------------------------------
set -a
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

set +a


#--------------------------------------------
# Cleanup Logic:
#--------------------------------------------
function __drone_pu_cleanup() {
    log_debug "Removing temp file \"${__DEFAULT_DEPFILE}\""
    rm -f "${__DEFAULT_DEPFILE}"
}

trap __drone_pu_cleanup SIGINT SIGTERM


#--------------------------------------------
# Main:
#--------------------------------------------
function main() {
    local m_file
    m_file="${__thisdir}/makefile"
    log_info "Using makefile: ${m_file}"
    log_info "Generating diagrams for ${PU_ROOT}"

    cd "${PU_ROOT}"
    export VPATH="${PU_ROOT}"
    make -f "${m_file}" "$@" \
        | cat -vte

    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        err_bail "Failed to generate diagrams for ${PU_ROOT}"
    fi

    log_info "Done"
}

main "$@"
__drone_pu_cleanup

# EOF

