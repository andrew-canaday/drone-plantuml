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
PU_ROOT="${PU_ROOT:-"${PWD}"}" ; PU_ROOT="${PU_ROOT%/*}"
PLANTUML="${PLANTUML:-"$( command -v plantuml )"}"

__DEFAULT_DEPFILE="$( mktemp )"
DEPFILE="${DEPFILE:-"${__DEFAULT_DEPFILE}"}"
export PLANTUML DEPFILE PU_ROOT

#--------------------------------------------
# Cleanup Logic:
#--------------------------------------------
function __drone_pu_cleanup() {
    rm -f "${__DEFAULT_DEPFILE}"
}

trap __drone_pu_cleanup SIGINT SIGTERM


#--------------------------------------------
# Utilities:
#--------------------------------------------
set -a
function log_info() {
    echo -e "\e[00;02m(${BASH_SOURCE[1]##*/}) \e[00;32mINFO: $@\e[00m" >&2
}

function log_debug() {
    if [ "x${DEBUG}" == "xyes" ]; then
        echo "DEBUG: $@" >&2
    fi
}

function err_bail() {
    echo -e "\e[00;02m(${BASH_SOURCE[1]##*/}) \e[00;31mERROR: $@\e[00m" >&2
    exit 1
}

# Print the value of a variable with name label.
# $1     - Variable name as a string
function print_var() {
    local var_name
    var_name="$1"
    printf "\e[00;34m%s\e[00m=\"\e[00;33m%s\e[00m\"\n" \
        "${var_name}" \
        "${!var_name}" >&2
}

set +a


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
        || err_bail "Failed to generate diagrams for ${PU_ROOT}"

    log_info "Done"
}

main "$@"
__drone_pu_cleanup

# EOF

