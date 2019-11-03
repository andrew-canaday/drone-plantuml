#===============================================================================
#
# makefile: Generate SVG/PNG+map diagrams from plantuml input
#
#===============================================================================

#-----------------
#      Vars:
#-----------------
SHELL := /bin/bash

# Dirs and tools:
# DEPFILE: (from environment!)
# PLANTUML: (from environment!)

# Sources and output:
SOURCES := $(shell find ./ -name "*.pu" )
HEADERS := $(shell find ./ -name "*.iuml" )
SVG_OBJ := $(SOURCES:%.pu=%.svg)
PNG_OBJ := $(SOURCES:%.pu=%.png)


all: info ${SVG_OBJ}

#----------------------------------------------------------------
# Dependency Tracking:
# This section is used to facilitate automatic dependency
# generation and tracking. It works as follows:
# - the dependency file is *included* to ensure that it *exists*:
#   - if missing, `make` will look for a target which creates it
#   - the $(DEPFILE) target is invoked, creating a fresh dependency
#     tracking file
#   - because an "included" file has just been generated, make
#     will halt evaluation and start over
#   - this time, the depfile is found and included, as if
#     dependency targets had been written into this file by hand
# - the $(DEPFILE) target is *automatically refreshed*:
#   - this is because the dependency file lists *all* sources and
#     headers as dependencies
#   - this causes the depfile to be regenereated whenever a
#     source change has been made
#   - because an "included" file has just been generated, make
#     will halt evaluation and start over
#----------------------------------------------------------------
include $(DEPFILE)

$(DEPFILE): $(SOURCES) $(HEADERS)
	@log_info "Generating dependencies"
	@${__thisdir}/pu_depgen.sh ${PU_ROOT} > $(DEPFILE)
#---------------------------------------------------------------

#-----------------
#    Targets:
#-----------------
info:
	@log_debug "Run info:"
	@log_debug "    Root: ${PWD}"
	@log_debug "    Sources: ${SOURCES}"
	@log_debug "    Headers: ${HEADERS}"
	@log_debug "    SVG Targets: ${SVG_OBJ}"
	@log_debug "    PNG Targets: ${PNG_OBJ}"
	@log_debug "    Dep file: ${DEPFILE}"

# SVG:
svg: $(SVG_OBJ)

%.svg : %.pu
	@log_info "Rendering $< as SVG"
	@$(PLANTUML) -nometadata -tsvg $< -o "$(@D)"

# PNG:
png: $(PNG_OBJ)

%.png : %.pu
	@log_info "Rendering $< as PNG"
	@$(PLANTUML) -nometadata -tpng $< -o "$(@D)"

# Misc:
# clean:
# 	rm -f ${DEPFILE}

