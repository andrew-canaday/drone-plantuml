#!/usr/bin/env bash
#===============================================================================
#
# drone-plantuml.sh: Main entrypoint for drone.io plantuml diagram plugin
#
#===============================================================================
__thispath="${0}"
__thisdir="$( cd ${__thispath%/*} ; echo "${PWD}" )"
__thisname="${__thispath##*/}"
__thislib="${__thisdir}/lib"


#--------------------------------------------
# Load/export utilities:
#--------------------------------------------
declare -a __drone_plantuml_deps
__drone_plantuml_deps=(
    "output-util.sh"
    "plantuml-util.sh"
    "make-util.sh"
    "drone-util.sh"
)

set -a
for util_src in "${__drone_plantuml_deps[@]}"; do
    source "${__thislib}/${util_src}"
done
set +a


#--------------------------------------------
# Cleanup:
#--------------------------------------------
function __drone_pu_cleanup() {
    log_debug "Removing temp file \"${__DEFAULT_DEPFILE}\""
    rm -f "${__DEFAULT_DEPFILE}"
}
trap __drone_pu_cleanup SIGINT SIGTERM EXIT


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

# EOF

