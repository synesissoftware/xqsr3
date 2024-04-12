
# ######################################################################## #
# File:     lib/xqsr3/containers/multi_map.rb
#
# Purpose:  multimap container
#
# Created:  21st March 2007
# Updated:  29th March 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
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

      case arg
      when ::NilClass

        return self.new
      when ::Hash

        mm = self.new

        arg.each do |k, v|

          raise ArgumentError, "mapped elements in hashes must be arrays, #{v.class} given" unless v.kind_of? ::Array

          mm.store k, *v
        end

        return mm
      when ::Array

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

    @merge_is_multi = true

    @inner = Hash.new
  end

  # Obtains the values, if any, for the given key; returns +nil+ if no
  # values are stored
  def [] key

    return @inner[key]
  end

  # Adds/assigns a new key+values pair. Equivalent to
  #
  #   store(key, *values)
  #
  # * *Parameters:*
  #   - +key+ The element key
  #   - +values+ (Array) The values to be associated with the key
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +values+ is not an array
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

    case rhs
    when ::NilClass
      return false
    when ::Hash
      return rhs.size == @inner.size && rhs == @inner
    when self.class
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

  # Calls _block_ once for each key-value pair, passing the key and each
  # of its values in turn. If the values for a given key are empty and
  # +defaults+ is not empty, the block is invoked for that key (with
  # +defaults[0]+) once
  #
  # * *Exceptions:*
  #   - +ArgumentError+ if more than 1 +defaults+ is provided, or no block is given
  def each *defaults

    raise ArgumentError, "may only supply 0 or 1 defaults" if defaults.size > 1
    raise ArgumentError, 'block is required' unless block_given?

    @inner.each do |key, values|

      if values.empty? && !defaults.empty?

        yield key, defaults[0]

        next
      end

      values.each { |value| yield key, value }
    end
  end

  # Calls _block_ once for each key in the instance, passing the key. If no
  # block is provided, an enumerator is returned
  def each_key

    return @inner.each_key unless block_given?

    @inner.each_key { |key| yield key }
  end

  # Calls _block_ once for each key-values pair, passing the key and its
  # values array. If no block is provided, an enumerator is returned
  def each_unflattened

    return @inner.each unless block_given?

    @inner.each { |key, value| yield key, value }
  end

  # Calls _block_ once for each key-values pair, passing the key and its
  # values array and a key index. If no block is provided, an enumerator
  # is returned
  def each_unflattened_with_index

    return @inner.each_with_index unless block_given?

    @inner.each_with_index { |kv, index| yield kv, index }
  end

  # Calls _block_ once for each value in the instance, passing the value.
  # If no block is provided, an enumerator is returned
  def each_value

    return @inner.each_value unless block_given?

    @inner.each do |key, values|

      values.each { |value| yield value }
    end
  end

  # Calls _block_ once for each key-values, passing the key and each of its
  # values and a value index
  #
  # * *Exceptions:*
  #   - +ArgumentError+ if no block is given
  def each_with_index

    raise ArgumentError, 'block is required' unless block_given?

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

    case rhs
    when self.class
      return self == rhs
    else
      return false
    end
  end

  # Returns the values associated with the given key
  #
  # * *Parameters:*
  #   - +key+ The key
  #   - +default+ The default value
  def fetch key, default = (default_parameter_defaulted_ = true; nil), &block

    unless default_parameter_defaulted_

      case default
      when ::NilClass, ::Array
        ;
      else
        raise TypeError, "default parameter ('#{default}') must be of type #{::Array}, but was of type #{default.class}"
      end
    end

    unless @inner.has_key? key

      return default unless default_parameter_defaulted_

      if block_given?

        r = nil

        case block.arity
        when 0
          r = yield
        when 1
          r = yield key
        else
          raise ArgumentError, "given block must take a single parameter - #{block.arity} given"
        end

        case r
        when ::Array
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

  # Returns +true+ if any key has the given +value+; +false+ otherwise
  #
  # * *Parameters:*
  #   - +value+ The value for which to search
  def has_value? value

    @inner.each do |k, vals|

      return true if vals.include? value
    end

    false
  end

  # Returns +true+ if any key has the given +values+; +false+ otherwise
  #
  # * *Parameters:*
  #   - +values+ (Array) The values for which to search
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +value+ is not an Array
  def has_values? values

    raise TypeError, "'values' parameter must be of type #{::Array}" unless Array === values

    @inner.has_value? values
  end

  # Returns the key for the given value(s)
  #
  # * *Parameters:*
  #   - +values+ (Array) The value(s) for which to search
  #
  # If a single value is specified, the entries in the instance are
  # searched first for an exact match to all (1) value(s); if that fails,
  # then the first key with a values containing the given value is
  # returned
  def key *values

    case values.size
    when 0

      return nil
    when 1

      i = nil

      @inner.each do |k, vals|

        return k if vals == values

        if i.nil?

          i = k if vals.include? values[0]
        end
      end

      return i
    else

      @inner.each do |key, vals|

        return key if vals == values
      end

      return nil
    end
  end

  # The number of elements in the map
  def length

    @inner.size
  end

  # Returns a new instance containing a merging of the current instance and
  # the +other+ instance
  #
  # NOTE: where any key is found in both merging instances the values
  # resulting will be a concatenation of the sets of values
  #
  # * *Parameters:*
  #   - +other+ (MultiMap, Hash) The instance from which to merge
  #
  # * *Exceptions:*
  #   - +TypeError+ Raised if +other+ is not a MultiMap or a Hash
  def multi_merge other

    mm = self.class.new

    mm.merge! self
    mm.merge! other

    mm
  end

  # Merges the contents of +other+ into the current instance
  #
  # NOTE: where any key is found in both merging instances the values
  # resulting will be a concatenation of the sets of values
  #
  # * *Parameters:*
  #   - +other+ (MultiMap, Hash) The instance from which to merge
  #
  # * *Exceptions:*
  #   - +TypeError+ Raised if +other+ is not a MultiMap or a Hash
  def multi_merge! other

    case other
    when self.class

      ;
    when ::Hash

      ;
    else

      raise TypeError, "parameter must be an instance of #{self.class} or #{Hash}"
    end

    other.each do |k, v|

      self.push k, v
    end

    self
  end

  # Returns a new instance containing a merging of the current instance and
  # the +other+ instance
  #
  # NOTE: where any key is found in both merging instances the values from
  # +other+ will be used
  #
  # * *Parameters:*
  #   - +other+ (MultiMap, Hash) The instance from which to merge
  #
  # * *Exceptions:*
  #   - +TypeError+ Raised if +other+ is not a MultiMap or a Hash
  def strict_merge other

    mm = self.class.new

    mm.strict_merge! self
    mm.strict_merge! other

    mm
  end

  # Merges the contents of +other+ into the current instance
  #
  # NOTE: where any key is found in both merging instances the values from
  # +other+ will be used
  #
  # * *Parameters:*
  #   - +other+ (MultiMap, Hash) The instance from which to merge
  #
  # * *Exceptions:*
  #   - +TypeError+ Raised if +other+ is not a MultiMap or a Hash
  def strict_merge! other

    case other
    when self.class

      other.each_unflattened do |k, vals|

        self.store k, *vals
      end
    when ::Hash

      other.each do |k, v|

        self.store k, v
      end
    else

      raise TypeError, "parameter must be an instance of #{self.class} or #{Hash}"
    end

    self
  end

  # See #merge
  def merge other

    if @merge_is_multi

      multi_merge other
    else

      strict_merge other
    end
  end

  # See #merge!
  def merge! other

    if @merge_is_multi

      multi_merge! other
    else

      strict_merge! other
    end
  end

  # Pushes the given +key+ and +values+. If the +key+ is already in the
  # map then the +values+ will be concatenated with those already present
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +key+ The element key
  #   - +values+ (*Array) The value(s) to be pushed
  #
  # === Exceptions
  #  - +::RangeError+ raised if the value of +count+ results in a negative count for the given element
  #  - +::TypeError+ if +count+ is not an +::Integer+
  def push key, *values

    @inner[key] = [] unless @inner.has_key? key

    @inner[key].push(*values)
  end

  # Removes a key-value pair from the instance and return as a two-item
  # array
  def shift

    @inner.shift
  end

  alias size length

  # Causes an element with the given +key+ and +values+ to be stored. If an
  # element with the given +key+ already exists, its values will b
  # replaced
  def store key, *values

    @inner[key] = values
  end

  # Converts instance to an array of +[key,value]+ pairs
  def to_a

    self.flatten
  end

  # Obtains reference to internal hash instance (which must *not* be modified)
  def to_h

    @inner.to_h
  end

  # Obtains equivalent hash to instance
  def to_hash

    @elements.to_hash
  end

  # A string-form of the instance
  def to_s

    @inner.to_s
  end

  # An array of all values in the instance
  def values

    r = []

    @inner.values.each  { |vals| r += vals }

    r
  end

  # An array of all sets of values in the instance
  def values_unflattened

    @inner.values
  end
end # class MultiMap

end # module Containers
end # module Xqsr3

# ############################## end of file ############################# #

