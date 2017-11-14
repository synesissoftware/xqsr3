#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/to_symbol'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_String_to_symbol < Test::Unit::TestCase

	def test_empty_string

		assert_nil ''.to_symbol
	end

	def test_simple_string

		assert_equal :a, 'a'.to_symbol
	end

	def test_string_with_spaces

		assert_equal :some_symbol, 'some symbol'.to_symbol
		assert_nil 'some symbol'.to_symbol(reject_spaces: true)
		assert_nil 'some symbol'.to_symbol(reject_whitespace: true)
	end

	def test_string_with_tabs

		assert_equal :some_symbol, "some\tsymbol".to_symbol
		assert_nil "some\tsymbol".to_symbol(reject_tabs: true)
		assert_nil "some\tsymbol".to_symbol(reject_whitespace: true)
	end

	def test_string_with_hyphens

		assert_equal :some_symbol, 'some-symbol'.to_symbol
		assert_nil 'some-symbol'.to_symbol(reject_hyphens: true)
	end

	def test_string_with_transform_characters

		assert_nil 'some#funky$symbol'.to_symbol
		assert_nil 'some#funky$symbol'.to_symbol transform_characters: [ ?', ?$ ]
		assert_nil 'some#funky$symbol'.to_symbol transform_characters: [ ?#, ?' ]
		assert_equal :some_funky_symbol, 'some#funky$symbol'.to_symbol(transform_characters: [ ?#, ?$ ])
	end
end


