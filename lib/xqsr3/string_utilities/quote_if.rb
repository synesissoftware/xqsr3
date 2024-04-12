
# ######################################################################## #
# File:     lib/xqsr3/string_utilities/quote_if.rb
#
# Purpose:  Definition of the ::Xqsr3::StringUtilities::QuoteIf module
#
# Created:  3rd June 2017
# Updated:  12th April 2024
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


=begin
=end

module Xqsr3
module StringUtilities

  # +include+-able module that provides ::quote_if and #quote_if methods
  module QuoteIf

    private
    # @!visibility private
    module QuoteIf_Helper_ # :nodoc: all

      def self.string_quote_if_array_ s, options # :nodoc:

        s = s.to_s unless String === s

        quotes = options[:quotes] || [ '"', '"' ]
        quotes = [ quotes, quotes ] if String === quotes

        quotables = options[:quotables] || /\s/

        case quotables
        when ::String

          return s unless s.include? quotables
        when ::Array

          return s unless quotables.any? { |quotable| s.include? quotable }
        when ::Regexp

          return s unless s =~ quotables
        else

          raise ArgumentError, "Invalid type (#{quotables.class}) specified for quotables parameter"
        end

        return quotes[0] + s + quotes[1]
      end
    end
    public

    # Converts a string to a quoted form if necessary
    #
    # === Signature
    #
    # * *Parameters:*
    #   - +s+ (+String+) The string to be evaluated;
    #   - +options+ (+Hash+) Options that control the behaviour of the method;
    #
    # * *Options:*
    #   - +:quotes+ (+String+, +Array+) A string that is used as the opening and closing quotes, or an array whose first two elements are used as the opening and closing quotes. Defaults to +'"'+
    #   - +:quotables+ (+String+, +Array+, +Regexp+) A string representing the quotable character, or an array containing the quotable characters, or a regular expression that determines by match whether the string should be quoted. Defaults to the regular expression +/\s/+
    def self.quote_if s, **options

      QuoteIf_Helper_.string_quote_if_array_ s, options
    end

    # Converts the instance to a quoted form if necessary
    #
    # See Xqsr3::StringUtilities::QuoteIf::quite_if() for options
    def quote_if **options

      QuoteIf_Helper_.string_quote_if_array_ self, options
    end
  end # module QuoteIf
end # module StringUtilities
end # module Xqsr3

# ############################## end of file ############################# #

