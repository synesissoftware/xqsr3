
# ######################################################################## #
# File:     lib/xqsr3/extensions/integer/to_s_grp.rb
#
# Purpose:  Adds a to_s_grp() method to the Integer class
#
# Created:  29th March 2024
# Updated:  29th March 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2024, Matthew Wilson and Synesis Information Systems
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
# ::Integer

=begin
=end

class Integer

  # Extends +Integer+ type with the +#to_s_grp()+ method
  def to_s_grp *args, **options

    separator = options[:separator] || ','

    numbers =
    case args.size
    when 0

      []
    when 1
      case args[0]
      when ::Array

        args[0]
      when ::Integer

        [ args[0] ]
      else

        raise TypeError, "parameter 'args[0]' (#{args[0].class}) must be an instance of Integer, or an array containing instance(s) of Integer"
      end
    else

      args
    end


    case numbers.size
    when 0

      return self.to_s
    when 1

      return self.to_s.chars.to_a.reverse.each_slice(numbers[0]).map(&:join).join(',').reverse
    else

      reversed_chars = self.to_s.chars.to_a#.reverse

      r = []

      last_n = nil

      numbers.each do |n|

        r << separator unless r.empty?
        r << reversed_chars.pop(n).reverse

        last_n = n
      end

      until reversed_chars.empty?

        r << separator unless r.empty?
        r << reversed_chars.pop(last_n).reverse
      end

      r.flatten.join('').reverse
    end
  end
end # module Kernel

# ############################## end of file ############################# #

