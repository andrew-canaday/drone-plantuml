all: test

.PHONY: all test image clean

test: image
	docker run -it -v ${PWD}/demo:/opt/demo -e PU_ROOT=/opt/demo -e DEBUG=yes andrewcanaday/drone-plantuml:latest

image: Dockerfile
	./docker-build.sh

clean:
	rm -f ./demo/*.svg

# EOF

