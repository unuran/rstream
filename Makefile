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

# --- Help (default target) -------------------------------------------------

help:
	@echo ""
	@echo "  build    ... build package '${project}'"
	@echo "  check    ... check package '${project}' (run 'R CMD check')"
	@echo "  version  ... update version number and release date in documentation"
	@echo "  valgrind ... check package '${project}' using valgrind (very slow!)"
	@echo "  clean    ... clear working space"
	@echo ""

# --- Phony targets ---------------------------------------------------------

.PHONY: help  build check clean devel roxy src valgrind version

# --- rstream ---------------------------------------------------------------

build:
	${R} CMD build ${project}

check:
	(unset TEXINPUTS; ${R} CMD check --as-cran ${project}_*.tar.gz)

version:
	(cd ${project} && ../scripts/update-docu.pl -u)

valgrind:
	(unset TEXINPUTS; ${R} CMD check --use-valgrind --timings ${project}_*.tar.gz)
	@echo -e "\n * Valgrind output ..."
	@for Rout in `find ${project}.Rcheck/ -name *.Rout`; \
		do echo -e "\n = $$Rout:\n"; \
		grep -e '^==[0-9]\{3,\}== ' $$Rout; \
	done

# --- Clear working space ---------------------------------------------------

clean:
# Remove compiled files
	@rm -fv ./${project}/src/*.o ./${project}/src/*.so
# Remove R package files
	rm -rf ${project}.Rcheck
	rm -f ${project}_*.tar.gz
# Remove emacs backup files
	@find -L . -type f -name "*~" -exec rm -v {} ';'

# --- End -------------------------------------------------------------------




# --- Help (default target) -------------------------------------------------

#help:
#	@echo ""
#	@echo "  build    ... build package '${project}'"
#	@echo "  check    ... check package '${project}' (run 'R CMD check')"
#	@echo "  "
#	@echo "  src      ... copy (update) source files from UNU.RAN directory and run autotools"
#	@echo "  version  ... update version number and release date in documentation"
#	@echo "  roxy     ... update help pages (roxygenize package)"
#	@echo ""
#	@echo "  devel    ... build without vignettes etc (faster)"
#	@echo "  valgrind ... check package '${project}' using valgrind (very slow!)"
#	@echo ""
#	@echo "  clean    ... clear working space"
#	@echo ""



# --- Runuran ---------------------------------------------------------------

