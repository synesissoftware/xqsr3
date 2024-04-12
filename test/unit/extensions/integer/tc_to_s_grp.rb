#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/integer/to_s_grp'

require 'test/unit'


class Test_X_Integer_to_s_grp < Test::Unit::TestCase

  def test_no_args

    assert_equal "87654321", 87654321.to_s_grp
  end

  def test_single_number

    assert_equal "87,654,321", 87654321.to_s_grp(3)
    assert_equal "87,65,43,21", 87654321.to_s_grp(2)
    assert_equal "8,7,6,5,4,3,2,1", 87654321.to_s_grp(1)

    assert_equal "876,54321", 87654321.to_s_grp(5)
  end

  def test_array_with_single_number

    assert_equal "87,654,321", 87654321.to_s_grp([3])
    assert_equal "87,65,43,21", 87654321.to_s_grp([2])
    assert_equal "8,7,6,5,4,3,2,1", 87654321.to_s_grp([1])

    assert_equal "876,54321", 87654321.to_s_grp([5])
  end

  def test_with_multiple_numbers

    assert_equal "87,654,321", 87654321.to_s_grp(3, 3)
    assert_equal "87,65,43,21", 87654321.to_s_grp(2, 2, 2)
    assert_equal "8,7,6,5,4,3,2,1", 87654321.to_s_grp(1, 1, 1, 1, 1, 1, 1)

    assert_equal "876,54321", 87654321.to_s_grp(5, 5)

    assert_equal "8,76,54,321", 87654321.to_s_grp(3, 2, 2)
    assert_equal "8,76,54,321", 87654321.to_s_grp(3, 2)
    assert_equal "8,76,543,21", 87654321.to_s_grp(2, 3, 2)
  end

  def test_array_with_multiple_numbers

    assert_equal "87,654,321", 87654321.to_s_grp([3, 3])
    assert_equal "87,65,43,21", 87654321.to_s_grp([2, 2, 2])
    assert_equal "8,7,6,5,4,3,2,1", 87654321.to_s_grp([1, 1, 1, 1, 1, 1, 1])

    assert_equal "876,54321", 87654321.to_s_grp([5, 5])

    assert_equal "8,76,54,321", 87654321.to_s_grp([3, 2, 2])
    assert_equal "8,76,54,321", 87654321.to_s_grp([3, 2])
    assert_equal "8,76,543,21", 87654321.to_s_grp([2, 3, 2])
  end
end

