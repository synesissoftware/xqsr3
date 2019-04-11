
# ######################################################################## #
# File:         lib/xqsr3/string_utilities/nil_if_empty.rb
#
# Purpose:      Definition of the ::Xqsr3::StringUtilities::NilIfEmpty
#               module
#
# Created:      25th January 2018
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
# ::Xqsr3::StringUtilities::NilIfEmpty

=begin
=end

module Xqsr3
module StringUtilities

module NilIfEmpty

	private
	module NilIfEmpty_Helper_ #:nodoc:

		def self.string_nil_if_empty_array_ s

			return s if s && !s.empty?

			nil
		end
	end
	public

	# Returns +nil+ if the given string is empty, otherwise returning the
	# given string
	#
	# === Signature
	#
	# * *Parameters:*
	#
	# * *Required parameters*:
	#   - +s+:: [String] The string to be evaluated
	def self.string_nil_if_empty s

		NilIfEmpty_Helper_.string_nil_if_empty_array_ s
	end

	def nil_if_empty

		NilIfEmpty_Helper_.string_nil_if_empty_array_ self
	end
end # module NilIfEmpty

end # module StringUtilities
end # module Xqsr3

# ############################## end of file ############################# #


