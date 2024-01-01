
# ######################################################################## #
# File:     lib/xqsr3/hash_utilities/deep_transform.rb
#
# Purpose:  Definition of the Xqsr3::HashUtilities::DeepTransform module
#
# Created:  3rd June 2017
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


require 'xqsr3/quality/parameter_checking'

# ##########################################################
# ::Xqsr3::HashUtilities::DeepTransform

=begin
=end

module Xqsr3
module HashUtilities

module DeepTransform

	private
	def self.do_deep_transform_on_hashlike_ h, &block # :nodoc:

		::Xqsr3::Quality::ParameterChecking.check_parameter h, 'h', responds_to: [ :map ]

		case block.arity
		when 1

			h =
			Hash[h.map do |k, v|

				k = k.deep_transform(&block) if ::Hash === k
				v = v.deep_transform(&block) if ::Hash === v

				[yield(k), v]
			end]
		when 2

			h =
			Hash[h.map do |k, v|

				k = k.deep_transform(&block) if ::Hash === k
				v = v.deep_transform(&block) if ::Hash === v

				yield(k, v)
			end]
		else

			raise ArgumentError, "block arity must be 1 or 2"
		end

		h
	end

	def do_deep_transform_on_self_ &block # :nodoc:

		::Xqsr3::Quality::ParameterChecking.check_parameter h, 'h', responds_to: [ :[]=, :delete, :keys ]

		case block.arity
		when 1

			self.keys.each do |k|

				v	=	self.delete k

				k	=	k.deep_transform(&block) if ::Hash === k
				v	=	v.deep_transform(&block) if ::Hash === v

				self[yield(k)] = v
			end
		when 2

			self.keys.each do |k|

				v	=	self.delete k

				k	=	k.deep_transform(&block) if ::Hash === k
				v	=	v.deep_transform(&block) if ::Hash === v

				k, v	=	yield(k, v)
			end
		else

			raise ArgumentError, "block arity must be 1 or 2"
		end
	end
	public

	# Executes the given mandatory 1- or 2-parameter block on the receiving
	# instance, which must be a Hash or a type that responds to the +map+
	# message, returning a copy of the instance in which keys (1-parameter
	# block) or keys and values (2-parameter block) are transformed.
	def deep_transform &block

		DeepTransform.do_deep_transform_on_hashlike_(self, &block)
	end

	# Executes the given mandatory 1- or 2-parameter block on the receiving
	# instance, whihc must be a Hash or a type that responds to +[]+,
	# +delete+, and +keys+ messages, changing the keys (1-parameter block)
	# or keys and values (2-parameter block).
	#
	# @note This method is not strongly exception-safe - failure during
	#  transformation can result in a partially transformed instance
	def deep_transform! &block

		do_deep_transform_on_self_(&block)
	end

end # module DeepTransform

end # module HashUtilities
end # module Xqsr3

# ############################## end of file ############################# #

