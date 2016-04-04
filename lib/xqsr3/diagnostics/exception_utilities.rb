
# ######################################################################## #
# File:         lib/xqsr3/diagnostics/exception_utilities.rb
#
# Purpose:      Definition of the ExceptionUtilities module
#
# Created:      12th February 2015
# Updated:      3rd April 2016
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matt Wilson
#
# Copyright (c) 2015-2016, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################## #


module Xqsr3
module Diagnostics

module ExceptionUtilities

	# 

	def self.raise_with_options *args, **options

		# special handling in case called indirectly

		called_indirectly	=	options[:called_indirectly_06d353cb_5a6c_47ca_8dbe_ff76359c7e96]

		case called_indirectly
		when nil, false
			called_indirectly	=	0
		when true
			called_indirectly	=	1
		when ::Integer
		else
			abort "indirect-call option (#{called_indirectly}) has invalid type (#{called_indirectly.class})"
		end

		options.delete :called_indirectly_06d353cb_5a6c_47ca_8dbe_ff76359c7e96 if called_indirectly


		# Use cases:
		#
		# 1. No options
		# 2. Non-class and options
		# 3. Class and options
		#   3.a Class and options
		#   3.b Class and options and message
		#   3.c Class and options and message and call-stack

		class_given = args.size > 0 && args[0].is_a?(::Class)

		if class_given && !options.empty?

			exception_class_or_instance_or_message_string = args.shift

			# 3. Class and options

			#   3.a Class and options
			#   3.b Class and options and message
			#   3.c Class and options and message and call-stack


			xargs	=	[]

			xargs	<<	args.shift unless args.empty?

			x		=	exception_class_or_instance_or_message_string.new *xargs, **options

			rargs	=	[]
			rargs	<<	x
			rargs	+=	[ nil, args.shift ] unless args.empty?

			# now need to trim backtrace

			begin

				Kernel.raise *rargs
			rescue => x

				bt = x.backtrace
				(0..called_indirectly).each { bt.shift }
				Kernel.raise x, x.message, bt
			end
		end

		unless options.empty?

			# 2. Non-class and options

			warn "cannot utilise options in raise_with_options when first argument is non-class"
		else

			# 1. No options
		end


		# now need to trim backtrace

		begin

			Kernel.raise *args
		rescue => x

			bt = x.backtrace
			(0..called_indirectly).each { bt.shift }
			Kernel.raise x, x.message, bt
		end
	end
end # module ExceptionUtilities

end # module Diagnostics
end # module Xqsr3

# ############################## end of file ############################# #

