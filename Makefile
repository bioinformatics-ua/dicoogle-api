# Rui Lebre
#
# A simple Makefile for generating the Dicoogle
# java documentation.  To compile and generate javadoc a user can simply type
# 
# make
#
# at the command line.  To remove all of the files that were built and leave
# only the source files, a user can type
#
# make clean
#
# at the command line.  For more information about Makefiles see
#
# http://www.gnu.org/software/make/manual/make.html
#
# Additional information about javadoc can be found at
#
# https://www.oracle.com/technetwork/java/javase/documentation/index-137868.html


ifndef VERBOSE
.SILENT:
endif

# The top level directory
ROOT_DIR = $(shell pwd)
DOCS_DIR = $(ROOT_DIR)/docs
DICOOGLE_DIR = $(ROOT_DIR)/dicoogle
JAVADOC_DIR = $(DOCS_DIR)/javadoc
WEBAPI_DIR = $(DOCS_DIR)/webapi

# List of source files
SOURCE_LIST = $(shell find $(DICOOGLE_DIR) -type f -name "*.java")

# If target matches javadoc, get version. It not defined, generate LATEST
ifeq (javadoc,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  DICOOGLE_TARGET := $(wordlist 2,2,$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(DICOOGLE_TARGET):;@:)
endif

default: all 

all:
	make javadoc

javadoc:
	if [ $(words $(MAKECMDGOALS)) -lt 2 ] ; then \
        javadoc -Xdoclint:none -d $(JAVADOC_DIR) -linksource $(SOURCE_LIST) ;\
	else \
		make v$(DICOOGLE_TARGET) ;\
	fi

v2.3.1:
	cd $(DICOOGLE_DIR) && \
	git fetch && git fetch --tags && \
	git checkout 2.3.1 -f -B v2.3.1 && \
	cd $(ROOT_DIR)

	@echo 2.3.1

v2.4.0:
	cd $(DICOOGLE_DIR) && \
	git fetch && git fetch --tags && \
	git checkout 2.4.0 -f -B v2.4.0 && \
	cd $(ROOT_DIR)

	@echo 2.4.0

v2.5.0:
	cd $(DICOOGLE_DIR) && \
	git fetch && git fetch --tags && \
	git checkout 2.5.0 -f -B v2.5.0 && \
	cd $(ROOT_DIR)

	@echo 2.5.0

clean:
    # Remove all of the documentation
	@if [ -d $(DOCS_DIR) ]; then rm -r $(DOCS_DIR); fi;
