#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')


require 'xqsr3/extensions/string/to_bool'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_String_to_bool < Test::Unit::TestCase

  def test_parse_normal

    assert_true 'true'.to_bool
    assert_false 'false'.to_bool
  end

  def test_parse_custom_true_false

    true_values   = [ 'affirmative', 'yup' ]
    false_values  = [ 'negative', 'nope' ]

    assert_true 'affirmative'.to_bool true_values: true_values, false_values: false_values
    assert_true 'yup'.to_bool true_values: true_values, false_values: false_values
    assert_nil 'true'.to_bool true_values: true_values, false_values: false_values
    assert_false 'negative'.to_bool true_values: true_values, false_values: false_values
    assert_false 'nope'.to_bool true_values: true_values, false_values: false_values
    assert_nil 'false'.to_bool true_values: true_values, false_values: false_values
  end

  def test_parse_custom_true_false_regexes

    true_values   = [ /affirm/, /yup/ ]
    false_values  = [ 'negative', /no/ ]

    assert_true 'affirmative'.to_bool true_values: true_values, false_values: false_values
    assert_true 'yup'.to_bool true_values: true_values, false_values: false_values
    assert_nil 'true'.to_bool true_values: true_values, false_values: false_values
    assert_false 'negative'.to_bool true_values: true_values, false_values: false_values
    assert_false 'nope'.to_bool true_values: true_values, false_values: false_values
    assert_nil 'false'.to_bool true_values: true_values, false_values: false_values
  end
end

