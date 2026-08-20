# frozen_string_literal: true
# ######################################################################## #
# File:     lib/xqsr3/extensions/enumerable/unique.rb
#
# Purpose:  Adds a unique() method to the Enumerable module
#
# Created:  5th March 2007
# Updated:  19th August 2026
#
# Home:     https://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2026, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2007-2019, Matthew Wilson and Synesis Software
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


=begin
=end

module Enumerable

  # Removes all duplicate elements in a sequence subject to an optional
  # two-parameter block in order to return an array containing unique
  # elements. The first occurrence of each unique element is retained, in
  # encounter order.
  #
  # Without a block, uniqueness is determined by +Hash+ membership (i.e.
  # +#eql?+ / +#hash+).
  #
  # With a block of arity 2, the block is treated as an equality predicate:
  # when it returns a truey value for +(kept, candidate)+, +candidate+ is
  # treated as a duplicate of +kept+ and is discarded. Comparator mode is
  # O(n^2) in the number of elements.
  #
  #  [ 1, 2, 3 ].unique # => [ 1, 2, 3 ]
  #  [ 1, 2, 1, 3 ].unique # => [ 1, 2, 3 ]
  #  [ 1, 2, 1.0 ].unique { |a, b| a.to_s == b.to_s } # => [ 1, 2 ]
  def unique(&block)

    ar = self.to_a

    return ar if ar.length < 2

    unless block

      r = []
      h = {}

      ar.each do |v|

        unless h.has_key?(v)

          r << v
          h[v] = nil
        end
      end

      return r
    end

    raise ArgumentError, "block requires two parameters" unless block.arity == 2

    r = []

    ar.each do |v|

      unless r.any? { |kept| yield(kept, v) }

        r << v
      end
    end

    return r
  end
end # module Enumerable

# ############################## end of file ############################# #
