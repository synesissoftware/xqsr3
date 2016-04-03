#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../lib')

require 'xqsr3/version'

require 'test/unit'

class Test_version < Test::Unit::TestCase

	def test_has_VERSION

		assert defined? Xqsr3::VERSION
	end

	def test_has_VERSION_MAJOR

		assert defined? Xqsr3::VERSION_MAJOR
	end

	def test_has_VERSION_MINOR

		assert defined? Xqsr3::VERSION_MINOR
	end

	def test_has_VERSION_REVISION

		assert defined? Xqsr3::VERSION_REVISION
	end

	def test_VERSION_has_consistent_format

		assert_equal Xqsr3::VERSION, "#{Xqsr3::VERSION_MAJOR}.#{Xqsr3::VERSION_MINOR}.#{Xqsr3::VERSION_REVISION}"
	end
end


