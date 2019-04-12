
# ######################################################################## #
# File:         lib/xqsr3/string_utilities/to_symbol.rb
#
# Purpose:      Definition of the ::Xqsr3::StringUtilities::ToSymbol
#               module
#
# Created:      14th April 2016
# Updated:      12th April 2019
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2016-2019, Matthew Wilson and Synesis Software
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
# ::Xqsr3::StringUtilities::ToSymbol

=begin
=end

module Xqsr3
module StringUtilities

# To-symbol conversion facilities
#
module ToSymbol

	private
	module ToSymbol_Helper_ # :nodoc:

		module Constants # :nodoc:

			SymbolCharacters0	=	'abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ'
			SymbolCharactersN	=	'abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789'
		end

		def self.string_to_symbol_with_options_ s, options # :nodoc:

			case	s
			when	::String
				;
			else

				if s.respond_to? :to_str

					s = s.to_str
				else

					raise TypeError, "string argument must be of type #{::String} or a type that will respond to to_str"
				end
			end

			case	options
			when	::Hash
				;
			else

				raise TypeError, "options must be of type #{::Hash}, #{options.class} given"
			end

			return nil if s.empty?

			transform_characters = options[:transform_characters] || []

			s.chars.map.with_index do |c, index|

				if 0 != index && Constants::SymbolCharactersN.include?(c)

					c
				elsif 0 == index && Constants::SymbolCharacters0.include?(c)

					c
				else

					case	c
					when	'-'

						return nil if options[:reject_hyphens]
					when	' '

						return nil if options[:reject_spaces] || options[:reject_whitespace]
					when	?\t

						return nil if options[:reject_tabs] || options[:reject_whitespace]
					else

						return nil unless transform_characters.include? c
					end

					'_'
				end
			end.join('').to_sym
		end
	end
	public

	# Converts the given string +s+ to a symbol according to the given
	# +options+
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +s+ (String) The string to convert
	#   - +options+ (Hash) Options hash
	#
	# * *Options:*
	#   - +:reject_hyphens+ (boolean)
	#   - +:reject_spaces+ (boolean)
	#   - +:reject_tabs+ (boolean)
	#   - +:reject_whitespace+ (boolean)
	#   - +:transform_characters+ (boolean)
	def self.string_to_symbol s, options = {}

		ToSymbol_Helper_.string_to_symbol_with_options_ s, options
	end

	# Converts the instance to a symbol, according to the given +options+
	#
	# See Xqsr3::StringUtilities::ToSymbol::string_to_symbol for options
	def to_symbol options = {}

		ToSymbol_Helper_.string_to_symbol_with_options_ self, options
	end
end # module ToSymbol

end # module StringUtilities
end # module Xqsr3

# ############################## end of file ############################# #

