#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/extensions/string/ends_with'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'stringio'

class Test_String_ends_with < Test::Unit::TestCase

	def test_String_has_method

		assert ''.respond_to? :ends_with?
	end

	def test_with_nil

		assert ''.ends_with? nil
	end

	def test_with_single_strings

		assert ''.ends_with? ''
		assert 'a'.ends_with? ''
		assert 'a'.ends_with? 'a'
		assert_not 'b'.ends_with? 'a'
		assert_nil 'b'.ends_with? 'a'
		assert 'ab'.ends_with? 'b'
		assert 'abc'.ends_with? 'c'
		assert 'abc'.ends_with? 'bc'
		assert_not 'abc'.ends_with? 'ac'
		assert_nil 'abc'.ends_with? 'ac'

		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? ''
		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? 'z'
		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? 'yz'
		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? 'xyz'
		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? 'wxyz'
		assert 'abcdefghijklmnopqrstuvwxyz'.ends_with? 'vwxyz'
	end

	def test_multiple_strings

		assert ''.ends_with? '', 'd'
		assert_not ''.ends_with? 'c', 'd'
		assert_nil ''.ends_with? 'c', 'd'
		assert 'c'.ends_with? 'c', 'd'
		assert 'd'.ends_with? 'c', 'd'

		assert_equal 'd', 'abcd'.ends_with?('c', 'd')
	end

	def test_with_array

		prefixes = %w{ a c def }

		assert_not ''.ends_with? *prefixes
		assert_nil ''.ends_with? *prefixes
		assert ''.ends_with? *prefixes, ''
		assert 'abc'.ends_with? *prefixes
		assert_not 'd'.ends_with? *prefixes
		assert_nil 'd'.ends_with? *prefixes
		assert 'abcdef'.ends_with? *prefixes
	end
end


