
# ######################################################################## #
# File:     lib/xqsr3/extensions/kernel/integer.rb
#
# Purpose:  Adds a Integer 'overload' to the Kernel module
#
# Created:  21st November 2017
# Updated:  29th March 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
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


require 'xqsr3/conversion/integer_parser'

# ##########################################################
# ::Kernel

=begin
=end

module Kernel

  alias xqsr3_Integer_original_method Integer

  # A monkey-patch extension of +Kernel#Integer+ with +options+
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +arg+ The argument to be converted (to +Fixnum+ or +Bignum+)
  #   - +base+ A value of 0, or between 2 and 36. Defaults to 0
  #   - +options+ An options hash, containing any of the following options
  #   - +block+ An optional caller-supplied block that will be invoked with the +ArgumentError+ exception, allowing the caller to take additional action. If the block returns then its return value will be returned to the caller
  #
  # * *Options:*
  #   - +:default+ A default value to be used when +arg+ is +nil+ or cannot be converted by (the original) +Kernel#Integer+
  #   - +:nil+ Returns +nil+ if +arg+ is +nil+ or cannot be converted by (the original) +Kernel#Integer+. Ignored if +:default+ is specified
  def Integer(arg, base = 0, **options, &block)

    ::Xqsr3::Conversion::IntegerParser.to_integer arg, base = 0, **options, &block
  end

  private :xqsr3_Integer_original_method
end # module Kernel

# ############################## end of file ############################# #

