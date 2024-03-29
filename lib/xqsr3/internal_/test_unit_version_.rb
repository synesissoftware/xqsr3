
# provides reliable mechanism for checking the version of the
# Test::Unit module

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


