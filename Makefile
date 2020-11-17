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
DICOOGLE_DIR = $(ROOT_DIR)/dicoogle
DOCS_DIR = $(ROOT_DIR)/docs
JAVADOC_DIR = $(DOCS_DIR)/javadoc
WEBAPI_DIR = $(DOCS_DIR)/webapi


ifeq (javadoc,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  DICOOGLE_TARGET := $(wordlist 2,2,$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(DICOOGLE_TARGET):;@:)
endif

ifeq (webapi,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  DICOOGLE_TARGET := $(wordlist 2,2,$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(DICOOGLE_TARGET):;@:)
endif


default: all 

all:
	make javadoc
	make webapi

javadoc:
	if [ $(words $(MAKECMDGOALS)) -lt 2 ] ; then \
        make javadoc-v2.3.1 javadoc-v2.4.0 javadoc-v2.5.0 javadoc-vdev javadoc-vmaster;\
	else \
		make javadoc-v$(DICOOGLE_TARGET) ; \
	fi

webapi:
	sh scripts/build_webapi.sh -o $(WEBAPI_DIR)/dev -s $(DOCS_DIR)/static

javadoc-v2.3.1:
	sh scripts/build_javadoc.sh -d 2.3.1 -i $(DICOOGLE_DIR) -o $(JAVADOC_DIR)/v2.3.1

javadoc-v2.4.0:
	sh scripts/build_javadoc.sh -d 2.4.0 -i $(DICOOGLE_DIR) -o $(JAVADOC_DIR)/v2.4.0

javadoc-v2.5.0: 
	sh scripts/build_javadoc.sh -d 2.5.0 -i $(DICOOGLE_DIR) -o $(JAVADOC_DIR)/v2.5.0

javadoc-vdev:
	sh scripts/build_javadoc.sh -d dev -i $(DICOOGLE_DIR) -o $(JAVADOC_DIR)/dev

javadoc-vmaster:
	sh scripts/build_javadoc.sh -d master -i $(DICOOGLE_DIR) -o $(JAVADOC_DIR)/master


clean:
    # Remove all of the documentation
	@if [ -d $(DOCS_DIR) ]; then rm -r $(JAVADOC_DIR)/*/; rm -r $(WEBAPI_DIR)/*/; fi;
