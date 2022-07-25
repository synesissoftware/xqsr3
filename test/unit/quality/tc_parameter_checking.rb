#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../..', 'lib')

require 'xqsr3/quality/parameter_checking'

require 'xqsr3/extensions/test/unit'
require 'test/unit'


class Test_check_option_multiple_option_names < Test::Unit::TestCase

	include ::Xqsr3::Quality::ParameterChecking

	def check_method_stringise_stringize **options

		check_option options, [ :stringise, :stringize ], nil: true
	end

	def test_1

		assert_nil check_method_stringise_stringize()

		assert_nil check_method_stringise_stringize(abc: :abc)

		assert_equal :stringize, check_method_stringise_stringize(stringize: :stringize)
		assert_equal :stringise, check_method_stringise_stringize(stringise: :stringise)
		assert_equal :stringise, check_method_stringise_stringize(stringize: :stringize, stringise: :stringise)
		assert_equal :stringise, check_method_stringise_stringize(stringise: :stringise, stringize: :stringize)
	end
end

class Test_parameter_checks_as_separate_module < Test::Unit::TestCase

	PC = ::Xqsr3::Quality::ParameterChecking

	# test 1

	def check_method_1 a, **options

		PC.check_option options, :o1, nil: true
		PC.check_option options, :o2, nil: false

		PC.check_param a, 'a'
	end

	def test_1

		assert_raise ArgumentError do

			check_method_1(nil)
		end

		assert_equal true, check_method_1(true, o1: true, o2: false)
		assert_equal '', check_method_1('', o1: true, o2: false)
		assert_equal [], check_method_1([], o1: true, o2: false)
		assert_equal Hash.new, check_method_1(Hash.new, o1: true, o2: false)
	end


	# test 2
end

class Test_parameter_checks_as_included_module < Test::Unit::TestCase

	include ::Xqsr3::Quality::ParameterChecking

	# test 0

	def test_access_control_instance

		assert private_methods.include?(:check_param), "check_param() must be a private method of the instance"
		assert private_methods.include?(:check_parameter), "check_param() must be a private method of the instance"

		assert self.class.private_instance_methods.include?(:check_param), "check_param() must be a private method of the instance"
		assert self.class.private_instance_methods.include?(:check_parameter), "check_param() must be a private method of the instance"
	end

	def test_access_control_private

		assert self.class.private_methods.include?(:check_param), "check_param() must be a private method of the class"
		assert self.class.private_methods.include?(:check_parameter), "check_param() must be a private method of the class"
	end


	# test 1

	def check_method_1 a

		check_param a, 'a'
	end

	def self.check_method_1_class a

		check_param a, 'a'
	end

	def test_1

		assert_raise ArgumentError do

			check_method_1(nil)
		end

		assert_raise ArgumentError do

			self.class.check_method_1_class(nil)
		end

		assert_equal true, check_method_1(true)
		assert_equal '', check_method_1('')
		assert_equal [], check_method_1([])
		assert_equal Hash.new, check_method_1(Hash.new)

		assert_equal true, self.class.check_method_1_class(true)
		assert_equal '', self.class.check_method_1_class('')
		assert_equal [], self.class.check_method_1_class([])
		assert_equal Hash.new, self.class.check_method_1_class(Hash.new)
	end


	# test 2

	def check_method_2 a, types, options = {}

		check_param a, 'a', options.merge({ types: types })
	end

	def test_2

		assert_equal true, check_method_2(true, [ ::TrueClass ])
		assert_equal true, check_method_2(true, [ :boolean ])
		assert_equal true, check_method_2(true, [ ::TrueClass, ::String, ::Symbol ])
		assert_raise TypeError do
			check_method_2(true, [ ::String, ::Symbol, ::FalseClass ])
		end
		assert_equal true, check_method_2(true, [ ::TrueClass ], nothrow: true)
		assert_nil check_method_2(true, [ ::FalseClass ], nothrow: true)
		assert_nil check_method_2('abc', [ ::Symbol, ::Regexp ], nothrow: true)
		assert_nil check_method_2([ 'abc' ], [ [ ::Symbol ], ::Regexp ], nothrow: true)
		assert_not_nil check_method_2([ 'abc' ], [ [ ::String ], ::Regexp ], nothrow: true)
		assert_not_nil check_method_2(//, [ [ ::String ], ::Regexp ], nothrow: true)
		assert_not_nil check_method_2([ [ 'abc', 'def' ], [ 'ghi', 'jkl' ] ], [ [ ::String ], ::Regexp, [ ::Array ] ], nothrow: true)

		assert_not_nil check_method_2([ [ 'abc', 'def' ], [ 'ghi', 'jkl' ] ], [ [ ::String ], ::Regexp, [ ::Array ] ], nothrow: true) do |v|

			if ::Array === v

				na = v.count { |v2| ::Array === v2 }

				0 == na || v.size == na
			else

				true
			end
		end

		assert_nil check_method_2([ [ 'abc', 'def' ], nil, [ 'ghi', 'jkl' ] ], [ [ ::String ], ::Regexp, [ ::Array ] ], nothrow: true) do |v|

			if ::Array === v

				na = v.count { |v2| ::Array === v2 }

				0 == na || v.size == na
			else

				true
			end
		end
	end


	# test 3

	def check_method_3 a, types, values, options = {}

		check_param a, 'a', options.merge({ types: types, values: values })
	end

	def test_3

		assert_raise RangeError do
			check_method_3(-1, nil, [ 0..2 ])
		end
		assert_equal 0, check_method_3(0, nil, [ 0..2 ])
		assert_equal 1, check_method_3(1, nil, [ 0..2 ])
		assert_equal 2, check_method_3(2, nil, [ 0..2 ])
		assert_raise RangeError do
			check_method_3(3, nil, [ 0..2 ])
		end
	end


	# test 4

	def check_method_4 a, types, values, options = {}, &block

		check_param a, 'a', options.merge({ types: types, values: values }), &block
	end

	def test_4

		assert_equal 0, check_method_4(0, nil, nil)
		assert_equal 0, check_method_4(0, nil, nil) { |n| 0 == n }

		assert_raise RangeError do
			check_method_4(-1, nil, nil) { |n| 0 == n }
		end

		assert_raise ArgumentError do
			check_method_4('-1', nil, nil) { |n| 0 == n }
		end

		assert_raise TypeError do
			check_method_4('-1', [ ::Numeric ], nil)
		end
		assert_raise ArgumentError do
			check_method_4('-1', [ ::String ], [ '-2', '0', '+1', '+2' ])
		end
		assert_equal '-1', check_method_4('-1', [ ::String ], [ '-2', '-1', '0', '+1', '+2' ])
#		assert_raise RangeError do
#			check_method_4('-1', [ ::String ], [ '-2', '0', '+1', '+2' ]) {
#		end

#		check_param(id, 'id', types: ::Integer) { |v| raise ArgumentError, "'id' must be a positive integer" unless v > 0 }

	end



	# test 5

	def check_method_5 a, options = {}

		check_param a, 'a', options
	end

	def test_5

		assert_equal "", check_method_5("", require_empty: true)
		assert_equal "a", check_method_5("a", reject_empty: true)

		assert_raise ArgumentError do
			check_method_5("", reject_empty: true)
		end

if false
		assert_raise ArgumentError do
			check_method_5(nil)
		end

		assert_equal true, check_method_5(true)
		assert_equal '', check_method_5('')
		assert_equal [], check_method_5([])
		assert_equal Hash.new, check_method_5(Hash.new)
end
	end


	# test 6

	def check_method_6 a, types, values, options = {}, &block

		check_param a, 'a', options.merge({ types: types, values: values }), &block
	end

	def test_6

		begin
			check_method_6 '', [ ::Hash ], []

			assert(false, 'should not get here')
		rescue TypeError => ax

			assert_match(/^parameter 'a' \(String\) must be an instance of Hash$/, ax.message)
		rescue => x

			assert(false, "wrong exception type #{x.class} (with message '#{x.message}')")
		end


		begin
			check_method_6 '', [ ::String ], [ 'b', 'c', 'd' ]

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_match(/^parameter 'a' value '' not found equal\/within any of required values or ranges$/, ax.message)
		rescue => x

			assert(false, "wrong exception type #{x.class} (with message '#{x.message}')")
		end
	end


	# test 7 - verify that can include an array of types in the array of types

	def check_method_7 a, types, values, options = {}, &block

		check_param a, 'a', options.merge({ types: types, values: values }), &block
	end

	def test_7

		assert_equal [], check_method_7([], [ ::Array ], nil)

		assert_equal [ 'abc' ], check_method_7([ 'abc' ], [ ::Array ], nil)

		assert_equal [ 'abc' ], check_method_7([ 'abc' ], [ [ ::String ] ], nil)

		assert_equal [ 'abc' ], check_method_7([ 'abc' ], [ [ ::Regexp, ::String ] ], nil)

		assert_equal [ :'abc' ], check_method_7([ :'abc' ], [ [ ::Regexp, ::Symbol ] ], nil)


		begin
			check_method_7 [ 'abc' ], [ ::Symbol, [ ::Regexp, ::Symbol ], ::Hash ], nil

			assert(false, 'should not get here')
		rescue TypeError => ax

			assert_match(/^parameter 'a' \(Array\) must be an instance of Symbol or Hash, or an array containing instance\(s\) of Regexp or Symbol$/, ax.message)
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end


		begin
			check_method_7 [ 'abc' ], [ [ ::Regexp, ::Symbol ] ], nil

			assert(false, 'should not get here')
		rescue TypeError => ax

			assert_match(/^parameter 'a' \(Array\) must be an array containing instance\(s\) of Regexp or Symbol$/, ax.message)
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end
	end


	# responds_to

	def check_responds_to a, messages, options = {}, &block

		check_param a, 'a', options.merge({ responds_to: messages }), &block
	end

	def test_responds_to

		assert check_responds_to Hash.new, [ :[], :map, :to_s ]
		assert_raise ::TypeError do

			check_responds_to Hash.new, [ :this_is_not_a_Hash_method ]
		end

		# check can pass single types
		assert check_responds_to Hash.new, :[]
		assert check_responds_to Hash.new, :map
		assert check_responds_to Hash.new, :to_s
	end



	# test type:

	def check_method_type a, type

		check_parameter a, 'a', type: type
	end

	def self.check_method_type_class a, type

		check_parameter a, 'a', type: type
	end

	def test_type

		assert_kind_of ::String, check_method_type('', ::String)

		assert_raise TypeError do

			check_method_type :sym, ::String
		end

		assert_kind_of ::String, self.class.check_method_type_class('', ::String)

		assert_raise TypeError do

			self.class.check_method_type_class :sym, ::String
		end


		# arrays of strings

		assert_kind_of ::Array, check_method_type([ 'abc' ], [ ::String ])
	end


	# test treat_as_option

	def check_method_tao_1 h, o, options = {}, &block

		check_parameter h[o], o, options.merge({ treat_as_option: true }), &block
	end

	def test_tao_1

		assert_true check_method_tao_1({ thing: true }, :thing)
		assert_false check_method_tao_1({ thing: false }, :thing)
		assert_equal [], check_method_tao_1({ thing: [] }, :thing)

		begin
			check_method_tao_1({ thing: true }, :thingy)

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end

		begin
			check_method_tao_1({ thing: true }, 'thingy')

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option 'thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end

		begin
			check_method_tao_1({ thing: true }, ':thingy')

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end
	end


	# test treat_as_option

	def check_method_tao_2 h, o, options = {}, &block

		check_option h, o, options.merge({ }), &block
	end

	def check_method_tao_class_2 h, o, options = {}, &block

		check_option h, o, options.merge({ }), &block
	end

	def test_tao_2

		assert_true check_method_tao_2({ thing: true }, :thing)
		assert_false check_method_tao_2({ thing: false }, :thing)
		assert_equal [], check_method_tao_2({ thing: [] }, :thing)

		assert_true check_method_tao_class_2({ thing: true }, :thing)
		assert_false check_method_tao_class_2({ thing: false }, :thing)
		assert_equal [], check_method_tao_class_2({ thing: [] }, :thing)

		begin
			check_method_tao_2({ thing: true }, :thingy)

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end

		begin
			check_method_tao_2({ thing: true }, 'thingy')

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option 'thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end

		begin
			check_method_tao_2({ thing: true }, ':thingy')

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end
	end

	# test multiple option names

	def check_method_multiple_option_names h, o, options = {}, &block

		check_option h, o, options.merge({ }), &block
	end

	def test_multiple_option_names

		# normal cases

		thing	=	check_method_multiple_option_names({ thing: 123 }, :thing)
		assert_equal 123, thing


		thing	=	check_method_multiple_option_names({ thing: 123 }, :thingy, allow_nil: true)
		assert_nil thing


		begin
			check_method_multiple_option_names({ thing: 123 }, :thingy)

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end


		# multiple-name cases


		thing	=	check_method_multiple_option_names({ thing: 123 }, [ :thingy, :thing ])
		assert_equal 123, thing


		thing	=	check_method_multiple_option_names({ thing: 123 }, [ :thingy, :Thingy ], allow_nil: true)
		assert_nil thing


		begin
			check_method_multiple_option_names({ thing: 123 }, [ :thingy, :Thingy ])

			assert(false, 'should not get here')
		rescue ArgumentError => ax

			assert_equal "option ':thingy' may not be nil", ax.message
		rescue => x

			assert(false, "wrong exception type #{x.class}) (with message '#{x.message}'")
		end

		assert_raise_with_message(::ArgumentError, "option ':thingy' may not be nil") { check_option({ thing: 123 }, [ :thingy, :Thingy ]) }
		assert_raise_with_message(::ArgumentError, "option ':Thingy' may not be nil") { check_option({ thing: 123 }, [ :Thingy, :thingy ]) }

		# multiple-name cases where several present

		assert_equal 123, check_method_multiple_option_names({ thing: 123, thingy: 45 }, [ :thing, :thingy ])
		assert_equal 45, check_method_multiple_option_names({ thing: 123, thingy: 45 }, [ :thingy, :thing ])

		assert_equal 123, check_method_multiple_option_names({ thing: 123, thingy: 45 }, [ :Thingy, :thing, :thingy ])
		assert_equal 45, check_method_multiple_option_names({ thing: 123, thingy: 45 }, [ :Thingy, :thingy, :thing ])
	end

	# test strip_str_whitespace

	def check_method_strip_str_whitespace v, name, options = {}, &block

		check_parameter v, name, options, &block
	end

	def test_strip_str_whitespace

		assert_equal ' ', check_method_strip_str_whitespace(' ', 's')
		assert_equal ' ', check_method_strip_str_whitespace(' ', 's', strip_str_whitespace: false)
		assert_equal ' ', check_method_strip_str_whitespace(' ', 's', reject_empty: true, strip_str_whitespace: false)
		assert_equal '', check_method_strip_str_whitespace(' ', 's', strip_str_whitespace: true)
		assert_equal 'abc', check_method_strip_str_whitespace("\tabc     ", 's', strip_str_whitespace: true)

		assert_raise_with_message(::ArgumentError, /param.*s.*(?:may|must) not be empty/) { check_method_strip_str_whitespace('', 's', reject_empty: true) }
		assert_raise_with_message(::ArgumentError, /param.*s.*(?:may|must) not be empty/) { check_method_strip_str_whitespace(' ', 's', reject_empty: true, strip_str_whitespace: true) }
	end


	# test_allow_nil

	def test_allow_nil

		assert_raise_with_message(::ArgumentError, /parameter .*the_param.* may not be nil/) { check_parameter(nil, 'the_param') }

		assert_nil(check_parameter(nil, 'the_param', allow_nil: true))

		assert_nil(check_parameter(nil, 'the_param', nil: true))
	end


	# test_ignore_case

	def test_ignore_case

		assert_not_nil check_parameter('TheString', 'the_param', values: [ 'TheString', 'the-string' ])

		assert_raise_with_message(::ArgumentError, /parameter.*the_param.*not found.*values/) { check_parameter('THESTRING', 'the_param', values: [ 'TheString', 'the-string' ]) }

		assert_not_nil check_parameter('TheString', 'the_param', values: [ 'THESTRING', 'the-string' ], ignore_case: true)
	end

	def test_ignore_case_in_array

		assert_not_nil check_parameter([ 'abc', 'def' ], 'the_param', values: [ [ 'ABC', 'DEF' ], [ 'abc', 'def' ] ])

		assert_raise_with_message(::ArgumentError, /parameter.*the_param.*not found.*values/) { check_parameter([ 'Abc', 'Def' ], 'the_param', values: [ [ 'ABC', 'DEF' ], [ 'abc', 'def' ] ]) }

		assert_not_nil check_parameter([ 'Abc', 'Def' ], 'the_param', values: [ [ 'ABC', 'DEF' ], [ 'abc', 'def' ] ], ignore_case: true)

		assert_raise_with_message(::ArgumentError, /parameter.*the_param.*not found.*values/) { check_parameter([ 'Def', 'Abc' ], 'the_param', values: [ [ 'ABC', 'DEF' ], [ 'abc', 'def' ] ], ignore_case: true) }

	end

	def test_ignore_case_and_order_in_array

		assert_not_nil check_parameter([ 'Def', 'Abc', 'Ghi' ], 'the_param', values: [ [ 'GHI', 'ABC', 'DEF' ], [ 'ghi', 'abc', 'def' ] ], ignore_case: true, ignore_order: true)
	end

	def test_ignore_order_in_array

		assert_raise(::ArgumentError) { check_parameter([ 'abc', 'def', 'ghi' ], 'the_param', values: [ [ 'ghi', 'def', 'abc' ], [ 'ghi', 'abc', 'def' ] ]) }

		assert_not_nil check_parameter([ 'abc', 'def', 'ghi' ], 'the_param', values: [ [ 'ghi', 'def', 'abc' ], [ 'ghi', 'abc', 'def' ] ], ignore_order: true)
	end
end

