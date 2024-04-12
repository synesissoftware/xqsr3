#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/hash/except'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'

class Test_Hash_except < Test::Unit::TestCase

  def test_no_pairs_empty_keys

    h = {}

    assert_equal h, h.except([])

    i = {}

    i.except!(*[])

    assert_equal h, i
  end

  def test_no_pairs_some_keys

    h = {}

    assert_equal h, h.except('a', :b)

    i = {}

    i.except! 'a', :b

    assert_equal h, i
  end

  def test_no_pairs_some_non_matching_keys

    h = { a: 'a', 'b' => :b }

    assert_equal h, h.except('a', :b)

    i = h.dup

    i.except! 'a', :b

    assert_equal h, i
  end

  def test_no_pairs_some_matching_keys

    h = { a: 'a', 'b' => :b }

    assert_equal ({ 'b' => :b }), h.except(:a, :b, :c)

    i = h.dup

    i.except! :a, :b, :c

    assert_equal ({ 'b' => :b }), i
  end
end


