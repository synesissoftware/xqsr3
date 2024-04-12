#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/hash_utilities/key_matching'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_Xqsr3_HashUtilities_has_match_by_module < Test::Unit::TestCase

  Matching = ::Xqsr3::HashUtilities::KeyMatching

  def test_against_none_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_false Matching.has_match?(h, '')
    assert_true Matching.has_match?(h, 'def')
    assert_false Matching.has_match?(h, 'ghi')
    assert_true Matching.has_match?(h, :nil)
    assert_false Matching.has_match?(h, 'nil')
    assert_true Matching.has_match?(h, :sym)
    assert_false Matching.has_match?(h, 'sym')
  end

  def test_against_empty_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_true Matching.has_match?(h, //)

    assert_true Matching.has_match?(h, /def/)
    assert_true Matching.has_match?(h, /de/)
    assert_true Matching.has_match?(h, /^de/)
    assert_false Matching.has_match?(h, /de$/)
  end
end


require 'xqsr3/extensions/hash/has_match'

class Test_Xqsr3_HashUtilities_has_match_by_include < Test::Unit::TestCase

  def test_against_none_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_false h.has_match?('')
    assert_true h.has_match?('def')
    assert_false h.has_match?('ghi')
    assert_true h.has_match?(:nil)
    assert_false h.has_match?('nil')
    assert_true h.has_match?(:sym)
    assert_false h.has_match?('sym')
  end

  def test_against_empty_re

    h = {

      :abc => :abc,
      'abc' => 'abc',
      'def' => 'def',
      :nil => nil,
      :sym => :sym,
    }

    assert_true h.has_match?(//)

    assert_true h.has_match?(/def/)
    assert_true h.has_match?(/de/)
    assert_true h.has_match?(/^de/)
    assert_false h.has_match?(/de$/)
  end
end


