
# ######################################################################## #
# File:         lib/xqsr3/string_utilities/starts_with.rb
#
# Purpose:      Definition of the ::Xqsr3::StringUtilities::StartsWith
#               module
#
# Created:      13th April 2016
# Updated:      14th April 2016
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2016, Matthew Wilson and Synesis Software
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
# ::Xqsr3::StringUtilities::StartsWith

module Xqsr3
module StringUtilities

module StartsWith

	private
	module StartsWith_Helper_

		def self.string_starts_with_helper_ s, prefix

			if prefix.nil? || prefix.empty?

				return ''
			elsif prefix.size < s.size

				return prefix if s[0 ... prefix.size] == prefix
			elsif prefix.size == s.size

				return prefix if prefix == s
			else

				nil
			end

			nil
		end

		def self.string_starts_with_array_ s, args

			return '' if args.empty?

			args.each do |prefix|

				case	prefix
				when	::NilClass

					return ''
				when	::String

					r = self.string_starts_with_helper_ s, prefix

					return r if r
				else

					if prefix.respond_to? :to_str

						return self.string_starts_with_helper_ s.prefix.to_str
					end

					raise TypeError, "starts_with? can be passed instances of #{::String}, or nil, or types that respond to to_str"
				end
			end

			return nil
		end
	end
	public

	def self.string_starts_with? s, *args

		StartsWith_Helper_.string_starts_with_array_ s, args
	end

	def starts_with? *args

		StartsWith_Helper_.string_starts_with_array_ self, args
	end
end

end
end

# ############################## end of file ############################# #
