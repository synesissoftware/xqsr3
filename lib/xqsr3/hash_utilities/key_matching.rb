
# ######################################################################## #
# File:         lib/xqsr3/hash_utilities/key_matching.rb
#
# Purpose:      Definition of the ::Xqsr3::HashUtilities::KeyMatching
#               module
#
# Created:      15th November 2017
# Updated:      15th November 2017
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


require 'xqsr3/quality/parameter_checking'

# ##########################################################
# ::Xqsr3::HashUtilities::KeyMatching

=begin
=end

module Xqsr3
module HashUtilities

module KeyMatching

	private
	def self.do_match_ h, re, **options

		::Xqsr3::Quality::ParameterChecking.check_parameter h, 'h', responds_to: [ :[], :has_key?, :each ]

		return h[re] if h.has_key? re

		case re
		when ::Regexp

			h.each do |k, v|

				case k
				when ::Regexp

					next
				else

					return v if k.to_s =~ re
				end
			end
		else

			h.each do |k, v|

				case k
				when ::Regexp

					return v if re.to_s =~ k
				else

					next
				end
			end
		end

		nil
	end

	def self.do_has_match_ h, re, **options

		::Xqsr3::Quality::ParameterChecking.check_parameter h, 'h', responds_to: [ :[], :has_key?, :each ]

		return true if h.has_key? re

		case re
		when ::Regexp

			h.each do |k, v|

				case k
				when ::Regexp

					next
				else

					return true if k.to_s =~ re
				end
			end
		else

			h.each do |k, v|

				case k
				when ::Regexp

					return true if re.to_s =~ k
				else

					next
				end
			end
		end

		false
	end
	public

	# Retrieves the value object corresponding to the first key object that
	# matches the given +re+, in the hash +h+, according to the given
	# options.
	def self.match h, re, **options

		Xqsr3::HashUtilities::KeyMatching.do_match_ h, re, **options
	end

	# Returns true if the hash +h+ contains a key object that matches the
	# given +re+, according to the given options
	def self.has_match? h, re, **options

		Xqsr3::HashUtilities::KeyMatching.do_has_match_ h, re, **options
	end

	# Retrieves the value object corresponding to the first key object that
	# matches the given +re+, in the hash +h+, according to the given
	# options.
	def match h, re, **options

		Xqsr3::HashUtilities::KeyMatching.do_match_ h, re, **options
	end

	# Returns true if the hash +h+ contains a key object that matches the
	# given +re+, according to the given options
	def has_match? h, re, **options

		Xqsr3::HashUtilities::KeyMatching.do_has_match_ h, re, **options
	end

end # module KeyMatching

end # module HashUtilities
end # module Xqsr3

# ############################## end of file ############################# #

