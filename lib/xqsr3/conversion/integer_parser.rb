
# ######################################################################## #
# File:     lib/xqsr3/conversion/integer_parser.rb
#
# Purpose:  Definition of the Xqsr3::Conversion::IntegerParser module
#
# Created:  21st November 2017
# Updated:  11th December 2023
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2023, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2017-2019, Matthew Wilson and Synesis Software
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
# * Neither the names of the copyright holders nor the names of its
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


# ##########################################################
# ::Xqsr3::Conversion::IntegerParser

=begin
=end

module Xqsr3
module Conversion

# +include-able module that provides Integer parsing
module IntegerParser

	private
	# @!visibility private
	module IntegerParser_Helper_ # :nodoc: all

		if Kernel.respond_to?(:xqsr3_Integer_original_method)

			def self.invoke_Integer_1(arg)

				Kernel.xqsr3_Integer_original_method(arg)
			end

			def self.invoke_Integer_2(arg, base)

				Kernel.xqsr3_Integer_original_method(arg, base)
			end
		else

			def self.invoke_Integer_1(arg)

				Kernel.Integer(arg)
			end

			def self.invoke_Integer_2(arg, base)

				Kernel.Integer(arg, base)
			end
		end

		def self.invoke_Integer(arg, base)

			case arg
			when ::String

				self.invoke_Integer_2 arg, base
			else

				if $DEBUG

					case base
					when nil, 0

						;
					else

						warn "WARNING: #{self}::#{__method__}: " + 'base specified for non string value'
					end
				end

				self.invoke_Integer_1 arg
			end
		end

		def self.to_integer_ arg, base, options, &block

			case	options
			when	::Hash
				;
			else

				raise TypeError, "options must be of type #{::Hash}, #{options.class} given"
			end

			if block_given?

				begin

					return self.invoke_Integer arg, base
				rescue ArgumentError, TypeError => x

					return yield x, arg, base, options
				end
			end

			if options.has_key?(:default) || options[:nil]

				unless arg.nil?

					begin

						return self.invoke_Integer arg, base
					rescue ArgumentError, TypeError
					end
				end

				return options[:default] if options.has_key? :default

				return nil
			else

				self.invoke_Integer arg, base
			end
		end
	end # module IntegerParser_Helper_
	public

	# Attempts to convert a variable to an integer, according to the given
	# options and block
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +arg+ The argument to be converted (to +Fixnum+ or +Bignum+)
	#   - +base+ A value of 0, or between 2 and 36. Defaults to 0
	#   - +options+ An options hash, containing any of the following options
	#   - +block+ An optional caller-supplied 4-parameter block - taking the exception, +arg+, +base+, and +options+ - that will be invoked with the +ArgumentError+ exception, allowing the caller to take additional action. If the block returns then its return value will be returned to the caller
	#
	# * *Options:*
	#   - +:default+ A default value to be used when +arg+ is +nil+ or cannot be converted by (the original) +Kernel#Integer+
	#   - +:nil+ Returns +nil+ if +arg+ is +nil+ or cannot be converted by (the original) +Kernel#Integer+. Ignored if +:default+ is specified
	def self.to_integer arg, base = 0, **options, &block

		IntegerParser_Helper_.to_integer_ arg, base, options, &block
	end

	# Instance form of ::Xqsr3::Conversion::IntegerParser.to_integer
	def to_integer base = 0, **options, &block

		IntegerParser_Helper_.to_integer_ self, base, options, &block
	end

end # module IntegerParser

end # module Conversion
end # module Xqsr3

# ############################## end of file ############################# #

