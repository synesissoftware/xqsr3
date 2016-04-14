#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/starts_with'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'

class Test_String_starts_with < Test::Unit::TestCase

	def test_String_has_method

		assert ''.respond_to? :starts_with?
	end

	def test_with_nil

		assert ''.starts_with? nil
	end

	def test_with_single_strings

		assert ''.starts_with? ''
		assert 'a'.starts_with? ''
		assert 'a'.starts_with? 'a'
		assert_not 'b'.starts_with? 'a'
		assert_nil 'b'.starts_with? 'a'
		assert 'ab'.starts_with? 'a'
		assert 'abc'.starts_with? 'a'
		assert 'abc'.starts_with? 'ab'
		assert_not 'abc'.starts_with? 'ac'
		assert_nil 'abc'.starts_with? 'ac'

		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? ''
		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? 'a'
		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? 'ab'
		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? 'abc'
		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? 'abcd'
		assert 'abcdefghijklmnopqrstuvwxz'.starts_with? 'abcde'
	end

	def test_multiple_strings

		assert ''.starts_with? '', 'd'
		assert_not ''.starts_with? 'c', 'd'
		assert_nil ''.starts_with? 'c', 'd'
		assert 'c'.starts_with? 'c', 'd'
		assert 'd'.starts_with? 'c', 'd'

		assert_equal 'a', 'abcd'.starts_with?('a', 'b')
	end

	def test_with_array

		prefixes = %w{ a c def }

		assert_not ''.starts_with? *prefixes
		assert_nil ''.starts_with? *prefixes
		assert ''.starts_with? *prefixes, ''
		assert 'abc'.starts_with? *prefixes
		assert_not 'd'.starts_with? *prefixes
		assert_nil 'd'.starts_with? *prefixes
		assert 'defghi'.starts_with? *prefixes
	end
end


