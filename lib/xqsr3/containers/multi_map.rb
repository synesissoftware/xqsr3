
# ######################################################################## #
# File:         lib/xqsr3/containers/multi_map.rb
#
# Purpose:      multimap container
#
# Created:      21st March 2007
# Updated:      12th April 2019
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2007-2019, Matthew Wilson and Synesis Software
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
# ::Xqsr3::Containers::MultiMap

=begin
=end

module Xqsr3
module Containers

# Hash-like class that stores as mapped values in arrays
class MultiMap < ::Hash

	include Enumerable

	# Creates an instance from the given arguments
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

					raise ArgumentError, "mapped elements in hashes must be arrays, #{v.class} given" unless v.kind_of? ::Array

					fm.store k, *v
				end

				return fm
			when	::Array

				# accepted forms:
				#
				# 1. Empty array
				# 2. Array exclusively of arrays

				# 1. Empty array

				return self.new if arg.empty?

				# 2. Array exclusively of arrays

				if arg.all? { |el| ::Array === el }

					h = Hash.new { |hash, key| hash[key] = [] }

					arg.each do |ar|

						raise ArgumentError, "cannot pass an empty array in array of arrays initialiser" if ar.empty?

						key = ar.shift

						ar.each { |value| h[key] << value }
					end

					return self.[](h)
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

	# Initialises an instance
	def initialize

		@inner	=	Hash.new
	end

	# Obtains the values, if any, for the given key; returns +nil+ if no
	# values are stored
	def [] key

		return @inner[key]
	end

	def []= key, values

		values = [] if values.nil?

		raise TypeError, "values must be an array, but #{values.class} given" unless values.kind_of? ::Array

		store key, *values
	end

	# Compares the instance for equality against +rhs+
	#
	# * *Parameters:*
	#   - +rhs+ (+nil+, +::Hash+, +MultiMap+) The instance to compare against
	#
	# * *Exceptions:*
	#   - +::TypeError+ if +rhs+ is not of the required type(s)
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

	# Searches the instance comparing each element with +key+, returning the
	# mapped values array if found, or +nil+ if not
	def assoc key

		@inner.assoc key
	end

	# Removes all elements from the instance
	def clear

		@inner.clear
	end

	# The total number of instances recorded
	def count

		@inner.each_value.map { |ar| ar.size}.inject(0, :+)
	end

	# Deletes all values mapped with the given +key+
	#
	# * *Parameters:*
	#   - +key+ The key to delete
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

	# Calls _block_ once for each element in the instance, passing the
	# key. If no block is provided, an enumerator is returned
	def each_key

		return @inner.each_key unless block_given?

		@inner.each_key { |key| yield key }
	end

	def each_unflattened

		@inner.each { |key, value| yield key, value }
	end

	def each_unflattened_with_index

		@inner.each_with_index { |kv, index| yield kv, index }
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

	# Returns +true+ if instance contains no elements; +false+ otherwise
	def empty?

		@inner.empty?
	end

	# Returns +true+ if +rhs+ is an instance of +MultiMap+ and contains
	# the same elements and their counts; +false+ otherwise
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

	# Returns the equivalent flattened form of the instance
	def flatten

		r = []

		@inner.each do |key, values|

			if values.empty?

				r << key << []
			else

				values.each do |value|

					r << key << value
				end
			end
		end

		r
	end

	# Returns +true+ if an element with the given +key+ is in the map; +false+
	# otherwise
	def has_key? key

		@inner.has_key? key
	end

	def has_value? value

		@inner.has_value? value
	end

	def key value

		@inner.key value
	end

	def merge fm

		raise TypeError, "parameter must be an instance of type #{self.class}" unless fm.instance_of? self.class

		fm_new = self.class.new

		fm_new.merge! self
		fm_new.merge! fm

		fm_new
	end

	def merge! fm

		fm.each do |k, v|

			self.push k, v
		end

		self
	end

	def push key, *values

		@inner[key] = [] unless @inner.has_key? key

		@inner[key].push(*values)
	end

	def shift

		@inner.shift
	end

	def size

		@inner.size
	end

	def store key, *values

		@inner[key] = values
	end

	def to_a

		self.flatten
	end

	def to_h

		@inner.dup
	end

	def values

		@inner.values
	end
end # class MultiMap

end # module Containers
end # module Xqsr3

# ############################## end of file ############################# #

