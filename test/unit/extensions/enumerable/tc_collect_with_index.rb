#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/enumerable/collect_with_index'

require 'test/unit'

class Test_Enumerable_collect_with_index < Test::Unit::TestCase

  def test_simple

    ar = [ 1, -2, 3, -4, 5, -6 ]

    r = ar.collect_with_index do |v, index0|

      index0 * v.abs
    end

    assert_equal [ 0, 2, 6, 12, 20, 30 ], r
  end

  def test_simple_with_offset

    ar = [ 1, -2, 3, -4, 5, -6 ]

    r = ar.collect_with_index(1) do |v, index0|

      index0 * v.abs
    end

    assert_equal [ 1, 4, 9, 16, 25, 36 ], r
  end
end


