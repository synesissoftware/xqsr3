#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/conversion/bool_parser'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_Xqsr3_ConversionMultiMap < Test::Unit::TestCase

	include ::Xqsr3::Conversion

	def test_parse_normal

		assert_true BoolParser.to_bool 'true'
		assert_false BoolParser.to_bool 'false'
	end

	def test_parse_custom_true_false

		true_values		=	[ 'affirmative', 'yup' ]
		false_values	=	[ 'negative', 'nope' ]

		assert_true BoolParser.to_bool 'affirmative', true_values: true_values, false_values: false_values
		assert_true BoolParser.to_bool 'yup', true_values: true_values, false_values: false_values
		assert_nil BoolParser.to_bool 'true', true_values: true_values, false_values: false_values
		assert_false BoolParser.to_bool 'negative', true_values: true_values, false_values: false_values
		assert_false BoolParser.to_bool 'nope', true_values: true_values, false_values: false_values
		assert_nil BoolParser.to_bool 'false', true_values: true_values, false_values: false_values
	end

	def test_parse_custom_true_false_regexes

		true_values		=	[ /affirm/, /yup/ ]
		false_values	=	[ 'negative', /no/ ]

		assert_true BoolParser.to_bool 'affirmative', true_values: true_values, false_values: false_values
		assert_true BoolParser.to_bool 'yup', true_values: true_values, false_values: false_values
		assert_nil BoolParser.to_bool 'true', true_values: true_values, false_values: false_values
		assert_false BoolParser.to_bool 'negative', true_values: true_values, false_values: false_values
		assert_false BoolParser.to_bool 'nope', true_values: true_values, false_values: false_values
		assert_nil BoolParser.to_bool 'false', true_values: true_values, false_values: false_values
	end
end

