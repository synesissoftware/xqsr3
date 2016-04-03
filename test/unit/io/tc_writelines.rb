#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/io/writelines'

require 'test/unit'

require 'stringio'

include ::Xqsr3::IO

class Test_Xqsr3_IO_writelines < Test::Unit::TestCase

	def test_single_string

		input = 'abc'

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_single_string_in_array

		input = [ 'abc' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_single_string_in_hash

		input = { 'abc' => '' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 1, r
		assert_equal "abc\n", s.string
	end

	def test_two_strings_in_array

		input = [ 'abc', 'def' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 2, r
		assert_equal "abc\ndef\n", s.string
	end

	def test_two_strings_in_array_with_suppressed_eol

		input = [ 'abc', 'def' ]

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input, line_separator: ''

		assert_equal 2, r
		assert_equal "abcdef", s.string
	end

	def test_two_strings_in_hash

		input = { 'ab' => 'c', 'de' => 'f' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 2, r
		assert_equal "abc\ndef\n", s.string
	end

	def test_two_strings_in_hash_with_col_sep

		input = { 'ab' => 'c', 'de' => 'f' }

		s = StringIO.new '', 'a'

		r = ::Xqsr3::IO.writelines s, input, column_separator: "\t"

		assert_equal 2, r
		assert_equal "ab\tc\nde\tf\n", s.string
	end

	def test_ten_strings_in_array

		input = (0...10).map { |i| i.to_s }

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 10, r
		assert_equal "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n", s.string
	end

	def test_strings_with_cr_in_array

		input = [ "abc\n", "def\n", "ghi\n" ]

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input

		assert_equal 3, r
		assert_equal "abc\ndef\nghi\n", s.string
	end

	def test_strings_with_cr_in_array_and_line_sep

		input = [ "abc\n", "def\n", "ghi\n" ]

		s = StringIO.new

		r = ::Xqsr3::IO.writelines s, input, line_separator: '|'

		assert_equal 3, r
		assert_equal "abc\n|def\n|ghi\n|", s.string
	end
end


