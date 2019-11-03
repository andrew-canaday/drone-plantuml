#-------------------------------------------------------------------------------
#
# drone-plantuml: Dockerfile
#
#-------------------------------------------------------------------------------
FROM adoptopenjdk/openjdk11:alpine-slim

ENV LANG en_US.UTF-8
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8

#-------------------
#     Prereq:
#-------------------
RUN apk add --no-cache \
	bash \
	graphviz \
	ttf-droid \
	ttf-droid-nonlatin \
	curl \
	make \
	jq

#-------------------
#     Plantuml:
#-------------------
ENV PLANTUML_VERSION 1.2019.12
ENV PLANTUML_HOME /opt/plantuml
ENV PLANTUML_JAR "${PLANTUML_HOME}/plantuml.jar"
RUN mkdir -p "${PLANTUML_HOME}"
RUN curl \
	-L "https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download" \
	-o "${PLANTUML_JAR}"

#-------------------
#     Plugin:
#-------------------
ADD plugin /opt/drone-plantuml
ENTRYPOINT ["/bin/bash", "/opt/drone-plantuml/drone-plantuml.sh"]

# EOF

