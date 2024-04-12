
# ######################################################################## #
# File:     lib/xqsr3/array_utilities/join_with_or.rb
#
# Purpose:  Definition of the ::Xqsr3::ArrayUtilities::JoinWithOr module
#
# Created:  7th December 2017
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


# ##########################################################
# ::Xqsr3::ArrayUtilities::JoinWithOr

=begin
=end

require 'xqsr3/quality/parameter_checking'

module Xqsr3
module ArrayUtilities

# +include+-able module that provides sequence-joining functionality
module JoinWithOr

  extend self

  # Joins an array with grammatical appropriateness (with an 'or')
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +ar+ (Array) The array whose contents are to be joined
  #   - +options+ (Hash) Options that control the behaviour of the method
  #
  # * *Options:*
  #   - +:or+ (String) A string that is used instead of 'or'
  #   - +:oxford_comma+ (boolean) Determines whether an Oxford comma will be used. Default is +true+
  #   - +:quote_char+ (String) The quote character. Default is empty string ''
  #   - +:separator+ (String) The separator character. Default is ','
  def join_with_or ar, **options

    ::Xqsr3::Quality::ParameterChecking.check_parameter ar, 'ar', type: ::Array, allow_nil: true
    ::Xqsr3::Quality::ParameterChecking.check_parameter options, 'options', type: ::Hash, allow_nil: false

    ::Xqsr3::Quality::ParameterChecking.check_parameter options[:or], ':or', type: ::String, option: true, allow_nil: true
    ::Xqsr3::Quality::ParameterChecking.check_parameter options[:oxford_comma], ':oxford_comma', types: [ ::FalseClass, ::TrueClass ], option: true, allow_nil: true
    ::Xqsr3::Quality::ParameterChecking.check_parameter options[:quote_char], ':quote_char', type: ::String, option: true, allow_nil: true
    ::Xqsr3::Quality::ParameterChecking.check_parameter options[:separator], ':separator', type: ::String, option: true, allow_nil: true

    return '' if ar.nil?
    return '' if ar.empty?

    separator   = options[:separator] || ','
    or_word     = options[:or] || 'or'
    ox_comma    = (options.has_key?(:oxford_comma) && !options[:oxford_comma]) ? '' : separator
    quote_char  = options[:quote_char]

    ar = ar.map { |v| "#{quote_char}#{v}#{quote_char}" } if quote_char

    case ar.size
    when 1
      ar[0]
    when 2
      "#{ar[0]} #{or_word} #{ar[1]}"
    else
      "#{ar[0...-1].join(separator + ' ')}#{ox_comma} #{or_word} #{ar[-1]}"
    end
  end

end # module JoinWithOr

end # module ArrayUtilities
end # module Xqsr3

# ############################## end of file ############################# #

