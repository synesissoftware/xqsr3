
# ######################################################################## #
# File:         lib/xqsr3/containers/frequency_map.rb
#
# Purpose:      multimap container
#
# Created:      21st March 2007
# Updated:      11th April 2016
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2007-2016, Matthew Wilson and Synesis Software
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


# ##########################################################
# Xqsrt3::IO

module Xqsr3
module Containers

class MultiMap < ::Hash

	include Enumerable

#	private
#	alias old_new new
#	public
#
#	def new
#
#		old_new
#	end

	def initialize

		@inner	=	Hash.new
	end

	def [] key

		return @inner[key]
	end

	def == rhs

		case	rhs
		when	::NilClass
			return false
		when	::Hash
			return rhs.size == @inner.size && rhs == @inner
		when	self.class
			return rhs.size == self.size && rhs == @inner
		else
			raise TypeError, "can compare #{self.class} only to instances of #{self.class} and #{::Hash}, but #{rhs.class} given"
		end

		false
	end

	def assoc key

		@inner.assoc key
	end

	def clear

		@inner.clear
	end

	def count

		@inner.each_value.map { |ar| ar.size}.inject(0, :+)
	end

	def delete key

		@inner.delete key
	end

	def each *defaults

		raise ArgumentError, "may only supply 0 or 1 defaults" if defaults.size > 1

		@inner.each do |key, values|

			if values.empty? && !defaults.empty?

				yield key, defaults[0]

				next
			end

			values.each { |value| yield key, value }
		end
	end

	def each_key

		@inner.each_key { |key| yield key }
	end

	def each_value

		@inner.each do |key, values|

			values.each { |value| yield value }
		end
	end

	def each_with_index

		index = 0
		self.each do |key, value|

			yield key, value, index

			index += 1
		end
	end

	def empty?

		@inner.empty?
	end

	def eql? rhs

		case	rhs
		when	self.class
			return self == rhs
		else
			return false
		end
	end

	def fetch key, default = nil, &block

		case	default
		when	::NilClass, ::Array
			;
		else
			raise TypeError, "default parameter ('#{default}') must be of type #{::Array}, but was of type #{default.class}"
		end

		unless @inner.has_key? key

			return default unless default.nil?

			if block_given?

				r = nil

				case	block.arity
				when	0
					r = yield
				when	1
					r = yield key
				else
					raise ArgumentError, "given block must take a single parameter - #{block.arity} given"
				end

				case	r
				when	::Array
					;
				else
					raise ArgumentError, "given block must return a value of type #{::Array} or one convertible implicitly to such" unless r.respond_to? :to_ary

					r = r.to_ary
				end

				return r
			end

			raise KeyError, "given key '#{key}' (#{key.class}) does not exist"
		end

		@inner.fetch key
	end

	def flatten

		@inner.flatten
	end

	def key value

		@inner.key value
	end

	def push key, *values

		@inner[key]	=	[]	unless @inner.has_key? key

		@inner[key].push(*values)
	end

	def shift

		@inner.shift
	end

	def size

		@inner.size
	end

	def store key, *values

		@inner[key]	=	values
	end

	def values

		@inner.values
	end
end

end # module Containers
end # module Xqsr3

# ############################## end of file ############################# #

