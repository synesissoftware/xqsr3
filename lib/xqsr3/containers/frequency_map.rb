
# ######################################################################## #
# File:     lib/xqsr3/containers/frequency_map.rb
#
# Purpose:  FrequencyMap container
#
# Created:  28th January 2005
# Updated:  29th March 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2005-2019, Matthew Wilson and Synesis Software
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


require 'xqsr3/diagnostics/inspect_builder'

=begin
=end

module Xqsr3
module Containers

# Hash-like class that counts, as the map's values, the frequencies of
# elements, as the map's keys
class FrequencyMap

  include Enumerable
  include ::Xqsr3::Diagnostics::InspectBuilder

  # Class that provides a Hash[]-like syntax as follows:
  #
  #    fm = FrequencyMap::ByElement[ 'abc', 'def', 'abc', :x, 'x', :y ]
  #
  #    fm.empty? # => false
  #    fm.size   # => 5
  #    fm.count  # => 6
  #    fm['abc'] # => 2
  #    fm['def'] # => 1
  #    fm['ghi'] # => 0
  #    fm['x']   # => 1
  #    fm['y']   # => 0
  #    fm['z']   # => 0
  #    fm[:x]    # => 1
  #    fm[:y]    # => 1
  #    fm[:z]    # => 0
  ByElement = Class.new do

    # Create an instance of Xqsr3::FrequencyMap from an array
    def self.[] *args

      fm = FrequencyMap.new

      args.each { |el| fm << el }

      fm
    end

    private_class_method :new
  end

  # Creates an instance from the given arguments
  def self.[] *args

    return self.new if 0 == args.length

    if 1 == args.length

      arg = args[0]

      case arg
      when ::NilClass

        return self.new
      when ::Hash

        fm = self.new
        arg.each do |k, v|

          fm.store k, v
        end
        return fm
      when ::Array

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

  # Initialises an instance
  def initialize

    @elements = {}
    @count    = 0
  end

  # Pushes an element into the map, assigning it an initial count of 1
  #
  # * *Parameters:*
  #   - +key+ The element to insert
  def << key

    push key, 1
  end

  # Compares the instance for equality against +rhs+
  #
  # * *Parameters:*
  #   - +rhs+ (+nil+, +::Hash+, +FrequencyMap+) The instance to compare against
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +rhs+ is not of the required type(s)
  def == rhs

    case rhs
    when ::NilClass

      return false
    when ::Hash

      return rhs.size == @elements.size && rhs == @elements
    when self.class

      return rhs.count == self.count && rhs == @elements
    else

      raise TypeError, "can compare #{self.class} only to instances of #{self.class} and #{::Hash}, but #{rhs.class} given"
    end

    false
  end

  # Obtains the count for a given key, or +nil+ if the key does not exist
  #
  # * *Parameters:*
  #   - +key+ The key to lookup
  def [] key

    @elements[key] || 0
  end

  # Assigns a key and a count
  #
  # * *Parameters:*
  #   - +key+ The key to lookup
  #   - +count+ (::Integer) The count to lookup
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +count+ is not an +::Integer+
  def []= key, count

    raise TypeError, "'count' parameter must be of type #{::Integer}, but was of type #{count.class}" unless Integer === count

    store key, count
  end

  # Searches the instance comparing each element with +key+, returning the
  # count if found, or +nil+ if not
  def assoc key

    @elements.assoc key
  end

  # Removes all elements from the instance
  def clear

    @elements.clear
    @count = 0
  end

  # The total number of instances recorded
  def count

    @count
  end

  # Obtains the default value of the instance, which will always be +nil+
  def default

    @elements.default
  end

  # Deletes the element with the given +key+ and its counts
  #
  # * *Parameters:*
  #   - +key+ The key to delete
  def delete key

    key_count = @elements.delete key

    @count -= key_count if key_count
  end

  # Duplicates the instance
  def dup

    fm = self.class.new

    fm.merge! self
  end

  # Calls _block_ once for each element in the instance, passing the element
  # and its frequency as parameters. If no block is provided, an enumerator
  # is returned
  def each

    return @elements.each unless block_given?

    @elements.each do |k, v|

      yield k, v
    end
  end

  # Enumerates each entry pair - element + frequency - in key order
  #
  # Note: this method is more expensive than +each+ because an array of
  # keys must be created and sorted from which enumeration is directed
  def each_by_key

    sorted_elements = @elements.sort { |a, b| a[0] <=> b[0] }

    return sorted_elements.each unless block_given?

    sorted_elements.each do |k, v|

      yield k, v
    end
  end

  # Enumerates each entry pair - element + frequency - in descending
  # order of frequency
  #
  # Note: this method is expensive, as it must create a new dictionary
  # and map all entries into it in order to achieve the ordering
  def each_by_frequency

    ar = @elements.to_a.sort { |a, b| b[1] <=> a[1] }

    return ar.each unless block_given?

    ar.each do |k, v|

      yield k, v
    end
  end

  # Calls _block_ once for each element in the instance, passing the
  # element. If no block is provided, an enumerator is returned
  def each_key

    return @elements.each_key unless block_given?

    keys.each do |element|

      yield element
    end
  end

  alias each_pair each

  # Calls _block_ once for each element in the instance, passing the
  # count. If no block is provided, an enumerator is returned
  def each_value

    return @elements.each_value unless block_given?

    keys.each do |element|

      yield @elements[element]
    end
  end

  # Returns +true+ if instance contains no elements; +false+ otherwise
  def empty?

    0 == size
  end

  # Returns +true+ if +rhs+ is an instance of +FrequencyMap+ and contains
  # the same elements and their counts; +false+ otherwise
  def eql? rhs

    case rhs
    when self.class
      return self == rhs
    else
      return false
    end
  end

  # Returns the count from the instance for the given element +key+. If
  # +key+ cannot be found, there are several options: with no other
  # arguments, it will raise a +::KeyError+ exception; if +default+ is
  # given, then that will be returned; if the optional code block is
  # specified, then that will be run and its result returned
  def fetch key, default = nil, &block

    case default
    when ::NilClass, ::Integer
      ;
    else
      raise TypeError, "default parameter ('#{default}') must be of type #{::Integer}, but was of type #{default.class}"
    end

    unless @elements.has_key? key

      return default unless default.nil?

      if block_given?

        case block.arity
        when 0
          return yield
        when 1
          return yield key
        else
          raise ArgumentError, "given block must take a single parameter - #{block.arity} given"
        end
      end

      raise KeyError, "given key '#{key}' (#{key.class}) does not exist"
    end

    @elements[key]
  end

  # Returns the equivalent flattened form of the instance
  def flatten

    @elements.flatten
  end

  # Returns +true+ if an element with the given +key+ is in the map; +false+
  # otherwise
  def has_key? key

    @elements.has_key? key
  end

  # Returns +true+ if an element with a count of the given +value+ is in the
  # map; +false+ otherwise
  #
  # * *Parameters:*
  #   - +value+ (Integer) The value of the count for which to search
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +value+ is not an Integer
  def has_value? value

    case value
    when ::NilClass, ::Integer
      ;
    else
      raise TypeError, "parameter ('#{value}') must be of type #{::Integer}, but was of type #{value.class}"
    end

    @elements.has_value? value
  end

  # A hash-code for this instance
  def hash

    @elements.hash
  end

  alias include? has_key?

  # A diagnostics string form of the instance
  def inspect

    make_inspect show_fields: true
  end

# def keep_if
#
# @elements.keep_if
# end
=begin
=end

  # Returns the element that has the given count, or +nil+ if none found
  #
  # * *Parameters:*
  #   - +count+ (::Integer) The count to lookup
  #
  # * *Exceptions:*
  #   - +::TypeError+ if +count+ is not of the required type(s)
  def key count

    raise TypeError, "'count' parameter must be of type #{::Integer}, but was of type #{count.class}" unless Integer === count

    @elements.key count
  end

  alias key? has_key?

  # An array of the elements only
  def keys

    @elements.keys
  end

  # The number of elements in the map
  def length

    @elements.length
  end

  alias member? has_key?

  # Returns a new instance containing a merging of the current instance and
  # the +fm+ instance
  #
  # NOTE: where any element is found in both merging instances the count
  # will be a combination of the two counts
  def merge fm

    raise TypeError, "parameter must be an instance of type #{self.class}" unless fm.instance_of? self.class

    fm_new = self.class.new

    fm_new.merge! self
    fm_new.merge! fm

    fm_new
  end

  # Merges the contents of +fm+ into the current instance
  #
  # NOTE: where any element is found in both merging instances the count
  # will be a combination of the two counts
  def merge! fm

    fm.each do |k, v|

      if not @elements.has_key? k

        @elements[k] = v
      else

        @elements[k] += v
      end
      @count += v
    end

    self
  end

  # Pushes the +element+ and +count+. If the +element+ already exists,
  # +count+ will be added to the existing count; otherwise it will be
  # +count+
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +key+ The element key
  #   - +count+ (Integer) The count by which to adjust
  #
  # === Exceptions
  #  - +::RangeError+ raised if the value of +count+ results in a negative count for the given element
  #  - +::TypeError+ if +count+ is not an +::Integer+
  def push key, count = 1

    raise TypeError, "'count' parameter must be of type #{::Integer}, but was of type #{count.class}" unless Integer === count

    initial_count = @elements[key] || 0
    resulting_count = initial_count + count

    raise RangeError, "count for element '#{key}' cannot be made negative" if resulting_count < 0

    if 0 == resulting_count

      @elements.delete key
    else

      @elements[key] = resulting_count
    end
    @count += count

    self
  end

  # Removes a key-value pair from the instance and return as a two-item
  # array
  def shift

    r = @elements.shift

    @count -= r[1] if ::Array === r

    r
  end

  alias size length

  # Causes an element with the given +key+ and +count+ to be stored. If an
  # element with the given +key+ already exists, its count will be adjusted,
  # as will the total count
  #
  # === Return
  #  +true+ if the element was inserted; +false+ if the element was
  #  overwritten
  def store key, count

    raise TypeError, "'count' parameter must be of type #{::Integer}, but was of type #{count.class}" unless Integer === count

    old_count = @elements[key] || 0

    @elements.store key, count

    @count += count - old_count

    old_count == 0
  end

  # Converts instance to an array of +[key,value]+ pairs
  def to_a

    @elements.to_a
  end

  # Obtains reference to internal hash instance (which must *not* be modified)
  def to_h

    @elements.to_h
  end

  # Obtains equivalent hash to instance
  def to_hash

    @elements.to_hash
  end

  # A string-form of the instance
  def to_s

    @elements.to_s
  end

  # An array of all frequencies (without element keys) in the instance
  def values

    @elements.values
  end
end # class FrequencyMap

end # module Containers
end # module Xqsr3

# ############################## end of file ############################# #

