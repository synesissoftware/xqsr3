
# ######################################################################## #
# File:         lib/xqsr3/extensions/enumerable/detect_map.rb
#
# Purpose:      ::Enumerable#detect_map extension
#
# Created:      3rd December 2017
# Updated:      12th April 2019
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2017-2019, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
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


=begin
=end

module Enumerable

	# The +Enumerable+#+detect+ method provides a way to detect the presence
	# of a particular value in a collection. The only constraint is that you
	# get back the object unchanged.
	#
	# The +Enumerable+#+map+ method provides a way to transform the contents of
	# a collection. The only constraint is that you get back another
	# collection.
	#
	# This extension method, +Enumerable+#+detect_map+ combines the features
	# of both, in that it detects the presence of a particular value in a
	# collection and transform the detected value.
	#
	#  [ 1, 2, 3 ].detect_map { |v| -2 * v if v > 2 } # => -6
	#
	#  { :ab => 'cd', :ef => 'gh' }.detect_map { |k, v| v.upcase if k == :ef } # => 'GH'
	#
	# *Note:* The block is required (for technical reasons), and must have
	# arity 1 for sequences or 2 for associations
	def detect_map &block

		case block.arity
		when 1

			self.each do |v|

				r = yield(v) and return r
			end
		when 2

			self.each do |k, v|

				r = yield(k, v) and return r
			end
		else

			raise ArgumentError, "detect_map requires block with arity of 1 (for sequences) or 2 (for associations); block with arity #{block.arity} given to instance of #{self.class}"
		end

		nil
	end
end # module Enumerable

# ############################## end of file ############################# #


