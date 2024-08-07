
# ######################################################################## #
# File:     lib/xqsr3/internal_/test_unit_version_.rb
#
# Purpose:  Provides reliable mechanism for checking the version of the
#           Test::Unit module
#
# Created:  March 2nd 2019
# Updated:  12th April 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
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
# * Neither the name of the copyright holder nor the names of its
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


require 'test/unit'


begin

  require 'test/unit/version'


  # :stopdoc:
  # @!visibility private
  module Xqsr3
  # @!visibility private
  module Internal_ # :nodoc:
  # @!visibility private
  module TestUnitVersion_ # :nodoc:

    # @!visibility private
    TEST_UNIT_VERSION_ = Test::Unit::VERSION # :nodoc:
  end # module TestUnitVersion_
  end # module Internal_
  end # module Xqsr3

  # :startdoc:
rescue LoadError

  # :stopdoc:
  # @!visibility private
  module Xqsr3
  # @!visibility private
  module Internal_ # :nodoc:
  # @!visibility private
  module TestUnitVersion_ # :nodoc:

    # @!visibility private
    TEST_UNIT_VERSION_ = :not_found # :nodoc:
  end # module TestUnitVersion_
  end # module Internal_
  end # module Xqsr3

  # :startdoc:
end

# :stopdoc:

module Xqsr3
module Internal_ # :nodoc:
module TestUnitVersion_ # :nodoc:

  if TEST_UNIT_VERSION_ == :not_found

    TEST_UNIT_VERSION_PARTS_ = []

    TEST_UNIT_VERSION_MAJOR_ = nil # :nodoc:
    TEST_UNIT_VERSION_MINOR_ = nil # :nodoc:
    TEST_UNIT_VERSION_PATCH_ = nil # :nodoc:
  else

    TEST_UNIT_VERSION_PARTS_ = TEST_UNIT_VERSION_.split(/[.]/).collect { |n| n.to_i } # :nodoc:

    TEST_UNIT_VERSION_MAJOR_ = TEST_UNIT_VERSION_PARTS_[0] # :nodoc:
    TEST_UNIT_VERSION_MINOR_ = TEST_UNIT_VERSION_PARTS_[1] # :nodoc:
    TEST_UNIT_VERSION_PATCH_ = TEST_UNIT_VERSION_PARTS_[2] # :nodoc:
  end

  # @!visibility private
  def self.less_ a1, a2 # :nodoc:

    n_common = a1.size < a2.size ? a1.size : a2.size

    (0...n_common).each do |ix|

      v1 = a1[ix]
      v2 = a2[ix]

      if v1 == v2

        next
      end

      if v1 < v2

        return true
      else

        return false
      end
    end

    if n_common != a2.size

      return true
    else

      return false
    end
  end

  # @!visibility private
  def self.is_major_at_least? j # :nodoc:

    return unless TEST_UNIT_VERSION_MAJOR_

    return j >= TEST_UNIT_VERSION_MAJOR_
  end

  # @!visibility private
  def self.is_minor_at_least? n # :nodoc:

    return unless TEST_UNIT_VERSION_MINOR_

    return n >= TEST_UNIT_VERSION_MINOR_
  end

  # @!visibility private
  def self.is_at_least? v # :nodoc:

    v = v.split(/\./).collect { |n| n.to_i } if String === v

    return !less_(TEST_UNIT_VERSION_PARTS_, v)
  end

  # @!visibility private
  def self.is_less? v # :nodoc:

    v = v.split(/\./).collect { |n| n.to_i } if String === v

    return less_(TEST_UNIT_VERSION_PARTS_, v)
  end

end # module TestUnitVersion_
end # module Internal_
end # module Xqsr3

# :startdoc:

# ############################## end of file ############################# #

