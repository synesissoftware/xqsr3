
# ######################################################################## #
# File:         lib/xqsr3/string_utilities/truncate.rb
#
# Purpose:      Definition of the ::Xqsr3::StringUtilities::Truncate
#               module
#
# Created:      12th April 2018
# Updated:      12th April 2019
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2018-2019, Matthew Wilson and Synesis Software
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
# ::Xqsr3::StringUtilities::Truncate

=begin
=end

module Xqsr3
module StringUtilities

# To-symbol conversion facilities
#
module Truncate

	private
	module Truncate_Helper_ # :nodoc:

		def self.string_truncate_with_options_ s, width, options # :nodoc:

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

			len	=	s.size

			return s if len <= width

			omission	=	options[:omission] || '...'

			if width < omission.size

				return omission[0...width]
			else

				return s[0...(width - omission.size)] + omission
			end
		end
	end
	public

	# Truncates the given string +s+ to the given +width+ according to the
	# given +options+
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +s+ (String) The string to convert
	#   - +width+ (Integer) The truncation width
	#   - +options+ (Hash) Options hash
	#
	# * *Options:*
	#   - +:omission+ (String) Omission string. Defaults to "..."
	def self.string_truncate s, width, options = {}

		Truncate_Helper_.string_truncate_with_options_ s, width, options
	end

	# Truncates the instance, according to the given +width+ and +options+
	#
	# See Xqsr3::StringUtilities::ToSymbol::string_truncate for options
	def truncate width, options = {}

		Truncate_Helper_.string_truncate_with_options_ self, width, options
	end
end # module Truncate

end # module StringUtilities
end # module Xqsr3

# ############################## end of file ############################# #


