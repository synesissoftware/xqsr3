
# ######################################################################## #
# File:         lib/xqsr3/extensions/kernel/raise_with_options.rb
#
# Purpose:      Extends the Kernel module with the raise_with_options
#               method
#
# Created:      12th February 2015
# Updated:      3rd April 2016
#
# Author:       Matt Wilson
#
# Copyright:    Synesis Software Pty Ltd, 2015-2016
#
# ######################################################################## #

require 'xqsr3/diagnostics/exception_utilities'

module Kernel

	def raise_with_options *args, **options

		options	||=	{}

		::Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options *args, **(options.merge({ :called_indirectly_06d353cb_5a6c_47ca_8dbe_ff76359c7e96 => 1}))
	end
end

# ############################## end of file ############################# #

