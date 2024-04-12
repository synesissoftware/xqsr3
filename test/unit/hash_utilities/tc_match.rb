#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')


require 'xqsr3/hash_utilities/key_matching'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_Xqsr3_HashUtilities_match_by_module < Test::Unit::TestCase

  Matching = ::Xqsr3::HashUtilities::KeyMatching

  def test_against_none_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_nil Matching.match(h, '')
    assert_not_nil Matching.match(h, 'def')
    assert_nil Matching.match(h, 'ghi')
    assert_nil Matching.match(h, :nil) # although this is matching!
    assert_nil Matching.match(h, 'nil')
    assert_not_nil Matching.match(h, :sym)
    assert_nil Matching.match(h, 'sym')
  end

  def test_against_empty_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_not_nil Matching.match(h, //)
    assert_equal h.first[1], Matching.match(h, //)

    assert_equal 'def', Matching.match(h, /def/)
    assert_equal 'def', Matching.match(h, /de/)
    assert_equal 'def', Matching.match(h, /^de/)
    assert_nil Matching.match(h, /de$/)
  end

  def test_hash_containing_re

    h = {

      /bc/ => :bc,
      /de/ => :de,
      :abc => :abc,
    }

    assert_nil Matching.match(h, '')
    assert_nil Matching.match(h, :ab)
    assert_equal :bc, Matching.match(h, :abcd)
  end
end


require 'xqsr3/extensions/hash/match'

class Test_Xqsr3_HashUtilities_match_by_include < Test::Unit::TestCase

  def test_against_none_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_nil h.match('')
    assert_not_nil h.match('def')
    assert_nil h.match('ghi')
    assert_nil h.match(:nil) # although this is matching!
    assert_nil h.match('nil')
    assert_not_nil h.match(:sym)
    assert_nil h.match('sym')
  end

  def test_against_empty_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_not_nil h.match(//)
    assert_equal h.first[1], h.match(//)

    assert_equal 'def', h.match(/def/)
    assert_equal 'def', h.match(/de/)
    assert_equal 'def', h.match(/^de/)
    assert_nil h.match(/de$/)
  end

  def test_hash_containing_re

    h = {

      /bc/ => :bc,
      /de/ => :de,
      :abc => :abc,
    }

    assert_nil h.match('')
    assert_nil h.match(:ab)
    assert_equal :bc, h.match(:abcd)
  end
end


