#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/array_utilities/join_with_or'

require 'xqsr3/extensions/test/unit'

require 'test/unit'


class Test_Xqsr3_ArrayUtilities_join_with_or_by_module < Test::Unit::TestCase

	JoinWithOr = ::Xqsr3::ArrayUtilities::JoinWithOr

	def test_default

		assert_equal '', JoinWithOr.join_with_or([])
		assert_equal 'a', JoinWithOr.join_with_or([ 'a' ])
		assert_equal 'a or b', JoinWithOr.join_with_or([ 'a', 'b' ])
		assert_equal 'a, b, or c', JoinWithOr.join_with_or([ 'a', 'b', 'c' ])
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, or n', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ])
	end

	def test_with_empty_options

		options = {

		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal 'a', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal 'a or b', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal 'a, b, or c', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, or n', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end

	def test_with_custom_or

		options = {

			:or => 'OR',
		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal 'a', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal 'a OR b', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal 'a, b, OR c', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, OR n', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end

	def test_with_no_oxford

		options = {

			:oxford_comma => false,
		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal 'a', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal 'a or b', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal 'a, b or c', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m or n', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end

	def test_with_custom_quote_char

		options = {

			:quote_char => '"',
		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal '"a"', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal '"a" or "b"', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal '"a", "b", or "c"', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal '"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", or "n"', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end

	def test_with_custom_separator

		options = {

			:separator => ';',
		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal 'a', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal 'a or b', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal 'a; b; or c', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal 'a; b; c; d; e; f; g; h; i; j; k; l; m; or n', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end

	def test_with_custom_flags

		options = {

			:or => 'OR',
			:oxford_comma => false,
			:quote_char => '"',
			:separator => ';',
		}

		assert_equal '', JoinWithOr.join_with_or([], **options)
		assert_equal '"a"', JoinWithOr.join_with_or([ 'a' ], **options)
		assert_equal '"a" OR "b"', JoinWithOr.join_with_or([ 'a', 'b' ], **options)
		assert_equal '"a"; "b" OR "c"', JoinWithOr.join_with_or([ 'a', 'b', 'c' ], **options)
		assert_equal '"a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"; "k"; "l"; "m" OR "n"', JoinWithOr.join_with_or([ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ], **options)
	end
end

require 'xqsr3/extensions/array/join_with_or'

class Test_Xqsr3_ArrayUtilities_join_with_or_by_include < Test::Unit::TestCase

	include ::Xqsr3::ArrayUtilities::JoinWithOr

	def test_default

		assert_equal '', [].join_with_or
		assert_equal 'a', [ 'a' ].join_with_or
		assert_equal 'a or b', [ 'a', 'b' ].join_with_or()
		assert_equal 'a, b, or c', [ 'a', 'b', 'c' ].join_with_or()
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, or n', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or()
	end

	def test_with_empty_options

		options = {

		}

		assert_equal '', [].join_with_or(**options)
		assert_equal 'a', [ 'a' ].join_with_or(**options)
		assert_equal 'a or b', [ 'a', 'b' ].join_with_or(**options)
		assert_equal 'a, b, or c', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, or n', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end

	def test_with_custom_or

		options = {

			:or => 'OR',
		}

		assert_equal '', [].join_with_or(**options)
		assert_equal 'a', [ 'a' ].join_with_or(**options)
		assert_equal 'a OR b', [ 'a', 'b' ].join_with_or(**options)
		assert_equal 'a, b, OR c', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m, OR n', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end

	def test_with_no_oxford

		options = {

			:oxford_comma => false,
		}

		assert_equal '', [].join_with_or(**options)
		assert_equal 'a', [ 'a' ].join_with_or(**options)
		assert_equal 'a or b', [ 'a', 'b' ].join_with_or(**options)
		assert_equal 'a, b or c', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal 'a, b, c, d, e, f, g, h, i, j, k, l, m or n', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end

	def test_with_custom_quote_char

		options = {

			:quote_char => '"',
		}

		assert_equal '', [].join_with_or(**options)
		assert_equal '"a"', [ 'a' ].join_with_or(**options)
		assert_equal '"a" or "b"', [ 'a', 'b' ].join_with_or(**options)
		assert_equal '"a", "b", or "c"', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal '"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", or "n"', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end

	def test_with_custom_separator

		options = {

			:separator => ';',
		}

		assert_equal '', [].join_with_or(**options)
		assert_equal 'a', [ 'a' ].join_with_or(**options)
		assert_equal 'a or b', [ 'a', 'b' ].join_with_or(**options)
		assert_equal 'a; b; or c', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal 'a; b; c; d; e; f; g; h; i; j; k; l; m; or n', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end

	def test_with_custom_flags

		options = {

			:or => 'OR',
			:oxford_comma => false,
			:quote_char => '"',
			:separator => ';',
		}

		assert_equal '', [].join_with_or(**options)
		assert_equal '"a"', [ 'a' ].join_with_or(**options)
		assert_equal '"a" OR "b"', [ 'a', 'b' ].join_with_or(**options)
		assert_equal '"a"; "b" OR "c"', [ 'a', 'b', 'c' ].join_with_or(**options)
		assert_equal '"a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"; "k"; "l"; "m" OR "n"', [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n' ].join_with_or(**options)
	end
end



