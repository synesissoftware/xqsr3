#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')


require 'xqsr3/conversion/bool_parser'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_Xqsr3_Conversion_BoolParser < Test::Unit::TestCase

  include ::Xqsr3::Conversion

  def test_parse_normal

    assert_true BoolParser.to_bool 'true'
    assert_true BoolParser.to_bool 'TRUE'
    assert_true BoolParser.to_bool '1'
    assert_false BoolParser.to_bool 'false'
    assert_false BoolParser.to_bool 'FALSE'
    assert_false BoolParser.to_bool '0'
  end

  def test_parse_rejects_substring_defaults

    assert_nil BoolParser.to_bool 'untrue'
    assert_nil BoolParser.to_bool 'truest'
    assert_nil BoolParser.to_bool 'unfalse'
    assert_nil BoolParser.to_bool 'falsehood'
  end

  def test_parse_default_value_and_aliases

    assert_equal :missing, BoolParser.to_bool('maybe', default_value: :missing)
    assert_equal :legacy, BoolParser.to_bool('maybe', default: :legacy)
    assert_nil BoolParser.to_bool('maybe', default_value: nil)
  end

  def test_parse_true_false_value_overrides

    assert_equal :yes, BoolParser.to_bool('true', true_value: :yes)
    assert_equal :no, BoolParser.to_bool('false', false_value: :no)
    assert_false BoolParser.to_bool('true', true_value: false)
    assert_true BoolParser.to_bool('false', false_value: true)
    assert_nil BoolParser.to_bool('true', true_value: nil)
    assert_false BoolParser.to_bool('true', true: false)
    assert_true BoolParser.to_bool('false', false: true)
  end

  def test_parse_custom_true_false

    true_values   = [ 'affirmative', 'yup' ]
    false_values  = [ 'negative', 'nope' ]

    assert_true BoolParser.to_bool 'affirmative', true_values: true_values, false_values: false_values
    assert_true BoolParser.to_bool 'yup', true_values: true_values, false_values: false_values
    assert_nil BoolParser.to_bool 'true', true_values: true_values, false_values: false_values
    assert_false BoolParser.to_bool 'negative', true_values: true_values, false_values: false_values
    assert_false BoolParser.to_bool 'nope', true_values: true_values, false_values: false_values
    assert_nil BoolParser.to_bool 'false', true_values: true_values, false_values: false_values
  end

  def test_parse_custom_true_false_regexes

    true_values   = [ /affirm/, /yup/ ]
    false_values  = [ 'negative', /no/ ]

    assert_true BoolParser.to_bool 'affirmative', true_values: true_values, false_values: false_values
    assert_true BoolParser.to_bool 'yup', true_values: true_values, false_values: false_values
    assert_nil BoolParser.to_bool 'true', true_values: true_values, false_values: false_values
    assert_false BoolParser.to_bool 'negative', true_values: true_values, false_values: false_values
    assert_false BoolParser.to_bool 'nope', true_values: true_values, false_values: false_values
    assert_nil BoolParser.to_bool 'false', true_values: true_values, false_values: false_values
  end
end
