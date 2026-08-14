#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/enumerable/unique'

require 'test/unit'


class Test_Enumerable_unique_test < Test::Unit::TestCase

  def test_empty

    src = []

    dest = src.unique

    assert dest.empty?
  end

  def test_already_unique

    src = [ 1, 2, 3, 4 ]

    dest = src.unique

    assert_equal src, dest
  end

  def test_unique_contiguous

    src = [ 1, 2, 3, 3, 4 ]

    dest = src.unique

    assert_equal [ 1, 2, 3, 4], dest
  end

  def test_unique_noncontiguous

    src = [ 1, 2, 3, 4, 3 ]

    dest = src.unique

    assert_equal [ 1, 2, 3, 4], dest
  end

  def test_unique_very_large_sorted

    max = 100000

    src = (0...max).to_a * 2
    exp = (0...max).to_a

    dest = src.unique

    assert_equal exp, dest
  end

  def test_unique_very_large_unsorted

    max = 100000

    src = ((0...max).to_a * 2).sort
    exp = (0...max).to_a

    dest = src.unique

    assert_equal exp, dest
  end

  def test_unique_with_comparator_block

    src = [ 1, 2, 1.0, 3 ]

    # Default uniqueness uses Hash (#eql?/#hash), so 1 and 1.0 both remain.
    assert_equal [ 1, 2, 1.0, 3 ], src.unique

    # Numeric == treats 1 and 1.0 as equal.
    dest = src.unique { |a, b| a == b }

    assert_equal [ 1, 2, 3 ], dest
  end

  def test_unique_with_comparator_block_to_s

    src = [ 1, 2, '1', 3, '2' ]

    dest = src.unique { |a, b| a.to_s == b.to_s }

    assert_equal [ 1, 2, 3 ], dest
  end

  def test_unique_with_comparator_block_preserves_first

    src = [ 'A', 'b', 'a', 'B' ]

    dest = src.unique { |a, b| a.downcase == b.downcase }

    assert_equal [ 'A', 'b' ], dest
  end

  def test_unique_with_wrong_arity_block

    assert_raise(ArgumentError) { [ 1, 2 ].unique { |a| a } }
  end
end

