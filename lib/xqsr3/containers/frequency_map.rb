
# ######################################################################## #
# File:         lib/xqsr3/containers/frequency_map.rb
#
# Purpose:      FrequencyMap container
#
# Created:      28th January 2005
# Updated:      13th April 2016
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2005-2016, Matthew Wilson and Synesis Software
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

class FrequencyMap

	include Enumerable

	ByElement = Class.new do

		def self.[] *args

			fm = FrequencyMap.new

			args.each { |el| fm << el }

			fm
		end

		private_class_method :new
	end

	def self.[] *args

		return self.new if 0 == args.length

		if 1 == args.length

			arg = args[0]

			case	arg
			when	::NilClass

				return self.new
			when	::Hash

				fm = self.new
				arg.each do |k, v|

					fm.store k, v
				end
				return fm
			when	::Array

				# accepted forms:
				#
				# 1. Empty array
				# 2. Array exclusively of two-element arrays
				# 3. Array of even number of elements and at every odd index is an integer

				# 1. Empty array

				return self.new if arg.empty?

				# 2. Array exclusively of two-element arrays

				if arg.all? { |el| ::Array === el && 2 == el.size }

					return self.[](::Hash.[]([ *arg ]))
				end

				# 3. Array of even number of elements and at every odd index is an integer

				if (0 == (arg.size % 2)) && arg.each_with_index.select { |el, index| 1 == (index % 2) }.map(&:first).all? { |el| el.kind_of? ::Integer }

					return self.[](::Hash.[](*arg))
				end


				raise ArgumentError, "array parameter not in an accepted form for subscript initialisation"
			else

				return self.[] arg.to_hash if arg.respond_to? :to_hash

				raise TypeError, "given argument is neither a #{::Hash} nor an #{::Array} and does not respond to the to_hash method"
			end

		else

			# treat all other argument permutations as having passed in an array

			return self.[] [ *args ]
		end
	end

	def initialize

		@counts	=   {}
		@count	=	0
	end

	def << key

		push key, 1
	end

	def == rhs

		case	rhs
		when	::NilClass
			return false
		when	::Hash
			return rhs.size == @counts.size && rhs == @counts
		when	self.class
			return rhs.count == self.count && rhs == @counts
		else
			raise TypeError, "can compare #{self.class} only to instances of #{self.class} and #{::Hash}, but #{rhs.class} given"
		end

		false
	end

	def [] key

		@counts[key]
	end

	def []= key, count

		store key, count
	end

	def assoc key

		@counts.assoc key
	end

	def clear

		@counts.clear
		@count = 0
	end

	# The total number of instances recorded
	def count

		@count
	end

	def default

		@counts.default
	end

	def delete key

		key_count = @counts.delete key

		@count -= key_count if key_count
	end

	def dup

		fm = self.class.new

		fm.merge! self
	end

	def each

		@counts.each do |k, v|

			yield k, v
		end
	end

	# Enumerates each entry pair - element + frequency - in descending
	# order of frequency
	#
	# Note: this method is expensive, as it must create a new dictionary
	# and map all entries into it in order to achieve the ordering
	def each_by_frequency

		tm = {}
		@counts.each do |element, frequency|

			if not tm.has_key? frequency

				tm[frequency] = [element]
			else

				tm[frequency].push element
			end
		end

		keys = tm.keys.sort.reverse
		keys.each do |frequency|

			elements = tm[frequency].sort
			elements.each do |element|

				yield element, frequency
			end
		end
	end

	def each_key

		keys.each do |element|

			yield element
		end
	end

	alias each_pair each

	def each_value

		keys.each do |element|

			yield @counts[element]
		end
	end

	def empty?

		0 == size
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
		when	::NilClass, ::Integer
			;
		else
			raise TypeError, "default parameter ('#{default}') must be of type #{::Integer}, but was of type #{default.class}"
		end

		unless @counts.has_key? key

			return default unless default.nil?

			if block_given?

				case	block.arity
				when	0
					return yield
				when	1
					return yield key
				else
					raise ArgumentError, "given block must take a single parameter - #{block.arity} given"
				end
			end

			raise KeyError, "given key '#{key}' (#{key.class}) does not exist"
		end

		@counts[key]
	end

	def flatten

		@counts.flatten
	end

	def has_key? key

		@counts.has_key? key
	end

	def has_value? value

		case	value
		when	::NilClass, ::Integer
			;
		else
			raise TypeError, "parameter ('#{value}') must be of type #{::Integer}, but was of type #{value.class}"
		end

		@counts.has_value? value
	end

	def hash

		@counts.hash
	end

	alias include? has_key?

	def inspect

		@counts.inspect
	end

#	def keep_if
#
#		@counts.keep_if
#	end

	def key value

		case	value
		when	::NilClass, ::Integer
			;
		else
			raise TypeError, "parameter ('#{value}') must be of type #{::Integer}, but was of type #{value.class}"
		end

		@counts.key value
	end

	alias key? has_key?

	def keys

		@counts.keys
	end

	def length

		@counts.length
	end

	alias member? has_key?

	def merge fm

		raise TypeError, "parameter must be an instance of type #{self.class}" unless fm.instance_of? self.class

		fm_new = self.class.new

		fm_new.merge! self
		fm_new.merge! fm

		fm_new
	end

	def merge! fm

		fm.each do |k, v|

			if not @counts.has_key? k

				@counts[k]	=	v
			else

				@counts[k]	+=	v
			end
			@count += v
		end

		self
	end

	def push element, count = 1

		raise TypeError, "count ('#{count}') must in an instance of #{::Integer}, but #{count.class} provided" unless count.kind_of? ::Integer

		if not @counts.has_key? element

			@counts[element]	=	count
		else

			@counts[element]	+=	count
		end
		@count += count

		self
	end

	def shift

		r = @counts.shift

		@count -= r[1] if ::Array === r

		r
	end

	alias size length

	def store key, value

		case	value
		when	::NilClass, ::Integer
			;
		else
			raise TypeError, "value ('#{value}') must be of type #{::Integer}, but was of type #{value.class}"
		end

		key_count = @counts[key] || 0

		@counts.store key, value

		@count += value - key_count
	end

	def to_a

		@counts.to_a
	end

	def to_h

		@counts.to_h
	end

	def to_hash

		@counts.to_hash
	end

	alias to_s inspect

	def values

		@counts.values
	end
end

end # module Containers
end # module Xqsr3

# ############################## end of file ############################# #

