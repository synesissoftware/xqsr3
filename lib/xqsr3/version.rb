
# ######################################################################### #
# File:         xqsr3/version.rb
#
# Purpose:      Version for Xqsr3 library
#
# Created:      3rd April 2016
# Updated:      3rd April 2016
#
# Author:       Matthew Wilson
#
# Copyright:    <<TBD>>
#
# ######################################################################### #


# Main module for Xqsr3 library
module Xqsr3

	# Current version of the Xqsr3 library
	VERSION				=	'0.2.1'

	private
	VERSION_PARTS_		=	VERSION.split(/[.]/).collect { |n| n.to_i } # :nodoc:
	public
	# Major version of the Xqsr3 library
	VERSION_MAJOR		=	VERSION_PARTS_[0] # :nodoc:
	# Minor version of the Xqsr3 library
	VERSION_MINOR		=	VERSION_PARTS_[1] # :nodoc:
	# Revision version of the Xqsr3 library
	VERSION_REVISION	=	VERSION_PARTS_[2] # :nodoc:

end # module Xqsr3

# ############################## end of file ############################## #

