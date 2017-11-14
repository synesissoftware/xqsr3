
# ######################################################################## #
# File:         lib/xqsr3/conversion/bool_parser.rb
#
# Purpose:      Definition of the ::Xqsr3::Conversion::BoolParser
#               module
#
# Created:      3rd June 2017
# Updated:      28th July 2017
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2017, Matthew Wilson and Synesis Software
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


# ##########################################################
# ::Xqsr3::Conversion::BoolParser

=begin
=end

module Xqsr3
module Conversion

module BoolParser

	private
	def self.matches_to_ s, expr

		case expr
		when ::Regexp
			return expr =~ s
		else
			return s == expr
		end
	end

	public

	DEFAULT_TRUE_VALUES		=	[ /true/i, '1' ]
	DEFAULT_FALSE_VALUES	=	[ /false/i, '0' ]

	# Attempts to parse the given String to a Boolean value, based on the
	# given +options+
	#
	# === Signature
	#
	# * *Parameters*:
	#   - +options+:: An options hash, containing any of the following options
	#
	# * *Options*:
	#   - +:false_values+:: [::Array] An array of strings or regular
	#     expressions against which to match for false value. Defaults to
	#     +DEFAULT_FALSE_VALUES+
	#   - +:true_values+:: [::Array] An array of strings or regular
	#     expressions against which to match for true value. Defaults to
	#     +DEFAULT_TRUE_VALUES+
	#   - +:default_value+:: An object to be returned if matching fails.
	#     Defaults to +nil+
	#   - +:false_value+:: An object to be returned if matching succeeds to
	#     match against +:false_values+.
	#   - +:true_value+:: An object to be returned if matching succeeds to
	#     match against +:true_values+.
	def self.to_bool s, **options

		true_values		=	options[:true_values] || DEFAULT_TRUE_VALUES
		true_values		=	[ true_values ] unless true_values.is_a? ::Array
		false_values	=	options[:false_values] || DEFAULT_FALSE_VALUES
		false_values	=	[ false_values ] unless false_values.is_a? ::Array
		default_value	=	options[:default] || nil
		true_value		=	options[:true] || true
		false_value		=	options[:false] || false

		return true_value if true_values.any? { |v| self.matches_to_ s, v }
		return false_value if false_values.any? { |v| self.matches_to_ s, v }

		return default_value
	end

end # module BoolParser

end # module Conversion
end # module Xqsr3

# ############################## end of file ############################# #

