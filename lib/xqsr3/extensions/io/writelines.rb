
# ######################################################################## #
# File:     lib/xqsr3/extensions/io/writelines.rb
#
# Purpose:  Adds a writelines() method to the IO class
#
# Created:  13th April 2007
# Updated:  12th April 2024
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


require 'xqsr3/io/writelines'

# ##########################################################
# ::IO

=begin
=end

class IO

  # Extends +IO+ class with the +::Xqsr3::IO::write_lines+ method
  #
  #
  #def self.writelines(path, contents, lineSep = nil, columnSep = nil)
  def self.writelines(path, contents, *args)

    options = {}

    case args.size
    when 0

      ;
    when 1

      arg3 = args[0]

      if arg3.respond_to?(:to_hash)

        options.merge! arg3.to_hash
      else

        options[:line_separator] = arg3
      end
    when 2

      arg3 = args[0]
      arg4 = args[1]

      options[:line_separator] = arg3
      options[:column_separator] = arg4
    else

      raise ArgumentError, "wrong number of arguments (given #{2 + args.size}, expected 2..4)"
    end

    ::Xqsr3::IO.writelines path, contents, **options
  end
end # class IO

# ############################## end of file ############################# #

