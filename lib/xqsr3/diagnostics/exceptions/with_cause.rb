
# ######################################################################## #
# File:     lib/xqsr3/diagnostics/exceptions/with_cause.rb
#
# Purpose:  Definition of the WithCause inclusion module
#
# Created:  16th December 2017
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
# ::Xqsr3::Diagnostics::Exceptions::WithCause

=begin
=end

module Xqsr3
module Diagnostics
module Exceptions

# This inclusion module adds to an exception class the means to chain a
# cause (aka inner-exception), which is then exposed with the +cause+
# attribute
#
# *Examples:*
#
# Passing an exception cause as a parameter
#
#
#
module WithCause

	# Array of hidden fields
	INSPECT_HIDDEN_FIELDS = [ 'has_implicit_message', 'uses_cause_message' ]

	# Defines an initializer for an exception class that allows a cause (aka
	# an inner exception) to be specified, either as the first or last
	# argument or as a +:cause+ option
	#
	# === Signature
	#
	# * *Parameters:*
	#  - +args+ 0+ arguments passed through to the +include+-ing class' initialiser
	#  - +options+ Options hash
	#
	# * *Options:*
	#  - +:cause+ - The exception to be used as a cause, and ensures that that is not inferred from the arguments. May be +nil+ to ensure that no cause is inferred
	def initialize(*args, **options)

		@uses_cause_message = false

		cz = options[:cause]

		if cz

			options = options.reject { |k, v| k == :cause }

			@has_implicit_message = args.empty?

			super(*args)

			warn 'unexpected implicit message' if @has_implicit_message && self.message != self.class.to_s

			@cause = cz
		else

			cz_ix = args.index { |arg| ::Exception === arg }

			if cz_ix

				args = args.dup

				cz = args.delete_at cz_ix

				if args.empty?

					if !(cz.message || '').empty? && cz.class.to_s != cz.message

						@uses_cause_message = true

						args = [ cz.message ]
					end
				end
			else

				cz = $!
			end

			@has_implicit_message = args.empty?

			super(*args)

			warn 'unexpected implicit message' if @has_implicit_message && self.message != self.class.to_s

			@cause = cz
		end

		@options = options
	end

	# The cause / inner-exception, if any, specified to the instance
	# initialiser
	attr_reader :cause

	# The options passed to the initialiser, with +:cause+ removed, if
	# present
	attr_reader :options

	# Message obtained by concatenation of all chained exceptions' messages
	#
	# === Signature
	#
	# * *Parameters:*
	#    - +options+ Options hash
	#
	# * *Options:*
	#    - +:separator+ (String) A string used to separate each chained exception message. Defaults to ": "
	def chained_message **options

		return message unless cause
		return message if @uses_cause_message

		m	=	message
		c	=	cause
		cm	=	c.respond_to?(:chained_message) ? c.chained_message(**options) : c.message

		return m if (cm || '').empty?
		return cm if (m || '').empty?

		sep	=	options[:separator] || ': '

		"#{m}#{sep}#{cm}"
	end

	# An array of exceptions in the chain, excluding +self+
	def chainees

		return [] unless cause

		r = [ cause ]

		r += cause.chainees if cause.respond_to? :chainees

		r
	end

	# An array of exceptions in the chain, including +self+
	def exceptions

		[ self ] + chainees
	end

	# A combination of the backtrace(s) of all chained exception(s)
	def chained_backtrace

		b = backtrace

		return b unless cause

		cb = cause.respond_to?(:chained_backtrace) ? cause.chained_backtrace : cause.backtrace

		(cb - b) + b
	end
end

end # module Exceptions
end # module Diagnostics
end # module Xqsr3

# ############################## end of file ############################# #

