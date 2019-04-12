#!/bin/bash

#############################################################################
# File:         generate_rdoc.sh
#
# Purpose:      Generates documentation
#
# Created:      11th June 2016
# Updated:      12th April 2016
#
#############################################################################

rm -rfd doc
rdoc \
	-x doc/ \
	-x gems/ \
	-x old-gems/ \
	-x test/scratch/ \
	-x ts_all.rb \
	-x tc_.*\.rb \
	-x build_gem.sh \
	-x generate_rdoc.sh \
	-x run_all_unit_tests.sh \
	-x xqsr3.gemspec \
	-x test_unit_version_ \
	$*


