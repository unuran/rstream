#############################################################################
#
#  Makefile for building and checking R package 'rstream'
#
#############################################################################

# --- Constants -------------------------------------------------------------

# name of project
project = rstream

# name of R program
R = R

# --- Default target --------------------------------------------------------

all: help

# --- Help ------------------------------------------------------------------

help:
	@echo ""
	@echo "build  ... build package '${project}'"
	@echo "check  ... check package '${project}'"
	@echo "clean  ... clear working space"
	@echo ""
	@echo "valgrind ... check package '${project}' using valgrind (slow!)"
	@echo ""

# --- Phony targets ---------------------------------------------------------

.PHONY: all help clean maintainer-clean clean build check

# --- rstream ---------------------------------------------------------------

build:
	${R} CMD build ${project}

check:
	(unset TEXINPUTS; ${R} CMD check --as-cran ${project}_*.tar.gz)

valgrind:
	(unset TEXINPUTS; ${R} CMD check --use-valgrind ${project}_*.tar.gz)
	@echo -e "\n * Valgrind output ..."
	@for Rout in `find ${project}.Rcheck/ -name *.Rout`; \
		do echo -e "\n = $$Rout:\n"; \
		grep -e '^==[0-9]\{3,\}== ' $$Rout; \
	done

# --- Clear working space ---------------------------------------------------

clean:
	@rm -rf ${project}.Rcheck
	@rm -fv ${project}_*.tar.gz
	@rm -fv ./${project}/src/*.o ./${project}/src/*.so
	@find -L . -type f -name "*~" -exec rm -v {} ';'

maintainer-clean: clean

# --- End -------------------------------------------------------------------
