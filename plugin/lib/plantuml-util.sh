#!/usr/bin/env bash
#===============================================================================
#
# plantuml-util.sh: Utility functions for running plantuml
#
#===============================================================================
function run_plantuml_jar() {
    java -jar "${PLANTUML_HOME}/plantuml.jar" "$@"
}

if [ -n "${PLANTUML_JAR}" ]; then
    PLANTUML="run_plantuml_jar"
else
    PLANTUML="${PLANTUML:-"$( command -v plantuml )"}"
fi

export PLANTUML

# EOF

