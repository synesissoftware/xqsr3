
# ######################################################################## #
# File:     lib/xqsr3/string_utilities/nil_if_whitespace.rb
#
# Purpose:  Definition of the Xqsr3::StringUtilities::NilIfWhitespace
#           module
#
# Created:  25th January 2018
# Updated:  11th December 2023
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2023, Matthew Wilson and Synesis Information Systems
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
# ::Xqsr3::StringUtilities::NilIfWhitespace

=begin
=end

module Xqsr3
module StringUtilities

# +include+-able module that provides ::string_nil_if_whitespace and
# #nil_if_whitespace methods
module NilIfWhitespace

	private
	# @!visibility private
	module NilIfWhitespace_Helper_ # :nodoc: all

		def self.string_nil_if_whitespace_array_ s # :nodoc:

			return nil if s.strip.empty?

			s
		end
	end
	public

	# Returns +nil+ if the given string is empty or contains only whitespace,
	# otherwise returning the given string
	#
	# === Signature
	#
	# * *Parameters:*
	#
	# * *Required parameters*:
	#   - +s+ (String) The string to be evaluated
	def self.string_nil_if_whitespace s

		NilIfWhitespace_Helper_.string_nil_if_whitespace_array_ s
	end

	# Returns +nil+ if the instance is empty or contains only whitespace,
	# otherwise returning self
	def nil_if_whitespace

		NilIfWhitespace_Helper_.string_nil_if_whitespace_array_ self
	end
end # module NilIfWhitespace

end # module StringUtilities
end # module Xqsr3

# ############################## end of file ############################# #

