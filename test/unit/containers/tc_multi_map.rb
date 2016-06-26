#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/containers/multi_map'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

include ::Xqsr3::Containers

class Test_Xqsr3_Containers_MultiMap < Test::Unit::TestCase

	def test_class_operator_subscript_1

		mm = MultiMap[]

		assert mm.empty?
		assert_equal 0, mm.size
	end

	def test_class_operator_subscript_2

		# as hash

		mm = MultiMap[ abc: [ 1 ], def: [ 'd' ] ]

		assert_not mm.empty?
		assert_equal [ :abc, 1, :def, 'd' ], mm.flatten
		assert_equal 2, mm.size
	end

	def test_class_operator_subscript_3

		mm = MultiMap[ [ :abc, 1 ], [ :def, 'd' ] ]

		assert_not mm.empty?
		assert_equal [ :abc, 1, :def, 'd' ], mm.flatten
		assert_equal 2, mm.size
	end

	def test_class_operator_subscript_4

		mm = MultiMap[ [ :abc, 1, 2, 3, 4 ], [ :def, 'd' ] ]

		assert_not mm.empty?
		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :def, 'd' ], mm.flatten
		assert_equal 2, mm.size
	end

	def test_class_operator_subscript_5

		assert_raise(::TypeError) { MultiMap[:not_a_hash] }

		assert_raise(::ArgumentError) { MultiMap[ abc: 1 ] }

		assert_raise(::ArgumentError) { MultiMap[ [ :abc ], 1 ] }

		assert_raise(::ArgumentError) { MultiMap[ [ :abc ], [] ] }
	end

	def test_instance_operator_equals

		mm1 = MultiMap.new
		mm2 = MultiMap.new

		assert_equal mm1, mm2

		mm1.push :abc

		assert_not_equal mm1, mm2

		mm2.push :abc

		assert_equal mm1, mm2

		mm1.push :abc, 1, 2, 3, 4, 5
		mm2.push :abc, 1, 2, 3, 4, 5

		assert_equal mm1, mm2
	end

	def test_instance_operator_subscript

		mm = MultiMap.new

		assert_nil mm[:abc]

		mm.push :abc

		assert_equal [], mm[:abc]

		mm.push :abc, 1, 2, 3

		assert_equal [ 1, 2, 3 ], mm[:abc]
	end

	def test_instance_operator_subscript_assign

		mm = MultiMap.new

		assert_nil mm[:abc]
		assert_equal 0, mm.count
		assert mm.empty?
		assert_equal 0, mm.size

		mm[:abc] = nil

		assert_equal [], mm[:abc]
		assert_equal 0, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.store :abc, 1, 2, '3', nil, false

		assert_equal [ 1, 2, '3', nil, false ], mm[:abc]
		assert_equal 5, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.store :abc

		assert_equal [], mm[:abc]
		assert_equal 0, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size
	end

	def test_assoc

		mm = MultiMap.new

		assert_nil mm.assoc :abc

		mm.push :abc

		assert_equal [ :abc, [] ], mm.assoc(:abc)

		mm.push :abc, 1, 2

		assert_equal [ :abc, [ 1, 2 ] ], mm.assoc(:abc)
	end

	def test_clear

		mm = MultiMap.new

		mm.push :abc, 'a'
		mm.push :abc, 'b'
		mm.push :abc, 'c'

		assert_equal 3, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.clear

		assert_equal 0, mm.count
		assert mm.empty?
		assert_equal 0, mm.size
	end

	def test_count_and_delete

		mm = MultiMap.new

		assert_equal 0, mm.count

		mm.push :abc, 1

		assert_equal 1, mm.count

		mm.push :abc, 2

		assert_equal 2, mm.count

		mm.push :def, 1

		assert_equal 3, mm.count

		mm.delete :ghi

		assert_equal 3, mm.count

		mm.delete :abc

		assert_equal 1, mm.count

		mm.delete :def

		assert_equal 0, mm.count
	end

	def test_count

		test_count_and_delete
	end

	def test_default

	end

	def test_delete

		test_count_and_delete
	end

	def test_dup

		mm1 = MultiMap.new

		mm1.push :def
		mm1.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm1.push :ghi, 'g1', 'g2'

		mm2 = mm1.dup

		assert_eql mm1, mm2
	end

	def test_each

		mm = MultiMap.new

		mm.push :def
		mm.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm.push :ghi, 'g1', 'g2'

		r = []

		mm.each do |k, v|

			r << [k, v]
		end

		r.sort!

		assert_equal 6, r.size
		assert_equal [ [ :abc, 'a1' ], [ :abc, 'a2' ], [ :abc, 'a3' ], [ :abc, 'a4' ], [ :ghi, 'g1' ], [ :ghi, 'g2' ] ], r
	end

	def test_each_with_default

		mm = MultiMap.new

		mm.push :def
		mm.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm.push :ghi, 'g1', 'g2'

		r = []

		mm.each(:the_default) do |k, v|

			r << [k, v]
		end

		r.sort!

		assert_equal 7, r.size
		assert_equal [ [ :abc, 'a1' ], [ :abc, 'a2' ], [ :abc, 'a3' ], [ :abc, 'a4' ], [ :def, :the_default ], [ :ghi, 'g1' ], [ :ghi, 'g2' ] ], r
	end

	def test_each_key

		mm = MultiMap.new

		mm.push :def
		mm.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm.push :ghi, 'g1', 'g2'

		r = []

		mm.each_key do |k|

			r << k
		end

		r.sort!

		assert_equal 3, r.size
		assert_equal [ :abc, :def, :ghi ], r
	end

	def test_each_value

		mm = MultiMap.new

		mm.push :def
		mm.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm.push :ghi, 'g1', 'g2'

		r = []

		mm.each_value do |v|

			r << v
		end

		r.sort!

		assert_equal 6, r.size
		assert_equal [ 'a1', 'a2', 'a3', 'a4', 'g1', 'g2' ], r
	end

	def test_each_with_index

		mm = MultiMap.new

		mm.push :def
		mm.push :abc, 'a1', 'a2', 'a3', 'a4'
		mm.push :ghi, 'g1', 'g2'

		r = []

		mm.each_with_index do |key, value, index|

			r << [ key, value, index ]
		end

		r.sort!

		assert_equal 6, r.size
		assert_equal [ [ :abc, 'a1', 0 ], [ :abc, 'a2', 1 ], [ :abc, 'a3', 2 ], [ :abc, 'a4', 3 ], [ :ghi, 'g1', 4 ], [ :ghi, 'g2', 5 ] ], r
	end

	def test_empty

		mm = MultiMap.new

		assert mm.empty?

		mm.push :abc

		assert_not mm.empty?
	end

	def test_eql?

		mm1 = MultiMap.new
		mm2 = MultiMap.new

		assert mm1.eql? mm1
		assert mm2.eql? mm2
		assert mm1.eql? mm2

		mm1.push :abc
		mm1.push :def

		assert mm1.eql? mm1
		assert mm2.eql? mm2
		assert_not mm1.eql? mm2

		mm2.push :def
		mm2.push :abc

		assert mm1.eql? mm1
		assert mm2.eql? mm2
		assert mm1.eql? mm2
	end

	def test_fetch

		mm = MultiMap.new

		assert_raise(::KeyError) { mm.fetch(:does_not_exist) }
		assert_equal [2], mm.fetch(:does_not_exist, [2])
		assert_raise(::TypeError) { mm.fetch(:does_not_exist, :wrong_type) }
		assert_raise(::ArgumentError) { mm.fetch(:does_not_exist) { |k| 33 } }
		assert_equal [ 33 ], mm.fetch(:does_not_exist) { |k| [ 33 ] }
		assert_equal [ 34 ], mm.fetch(:does_not_exist) { |k| [ 34 ] }

		mm.push :abc, 1, 2, 3

		assert_equal [ 1, 2, 3 ], mm.fetch(:abc)
		assert_equal [ 1, 2, 3 ], mm.fetch(:abc, [ 1 ])
		assert_equal [ 1, 2, 3 ], (mm.fetch(:abc) { |k| [ 33 ] })
	end

	def test_flatten

		mm = MultiMap.new

		assert_equal [], mm.flatten

		mm.push :abc

		assert_equal [ :abc, [] ], mm.flatten

		mm.push :abc, 1, 2, 3

		assert_equal [ :abc, 1, :abc, 2, :abc, 3 ], mm.flatten

		mm.push :abc, 4, 5

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5 ], mm.flatten

		mm.push :def

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5, :def, [] ], mm.flatten
	end

	def test_has_key?

		mm = MultiMap.new

		assert_not mm.has_key? :abc

		mm.push :abc

		assert mm.has_key? :abc

		mm.delete :abc

		assert_not mm.has_key? :abc
	end

	def test_has_value?

		mm = MultiMap.new

		assert_not mm.has_value? []

		mm.push :abc

		assert mm.has_value? []

		mm.delete :abc

		assert_not mm.has_value? []
	end

	def test_key

		mm = MultiMap.new

		assert_nil mm.key []
		assert_nil mm.key :not_defined

		mm.push :abc

		assert_equal :abc, mm.key([])

		mm.push :abc, 1

		assert_equal :abc, mm.key([ 1 ])
	end

	def test_length_and_size

		mm = MultiMap.new

		assert mm.empty?
		assert_equal 0, mm.size

		mm.push :abc, 1

		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.push :abc, 2

		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.push :def, 1

		assert_not mm.empty?
		assert_equal 2, mm.size
	end

	def test_length

		test_length_and_size
	end

	def test_merge

		mm1 = MultiMap.new

		mm1.push :abc, 1, 2, 3

		assert_equal [ :abc, 1, :abc, 2, :abc, 3 ], mm1.flatten

		mm2 = MultiMap.new

		mm2.push :abc, 4, 5
		mm2.push :def, 'a'

		mm3 = mm1.merge mm2

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5, :def, 'a' ], mm3.flatten
	end

	def test_merge!

		mm1 = MultiMap.new

		mm1.push :abc, 1, 2, 3

		assert_equal [ :abc, 1, :abc, 2, :abc, 3 ], mm1.flatten

		mm2 = MultiMap.new

		mm2.push :abc, 4, 5
		mm2.push :def, 'a'

		mm1.merge! mm2

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5, :def, 'a' ], mm1.flatten
	end

	def test_push

		mm = MultiMap.new

		assert_nil mm[:abc]
		assert_equal 0, mm.count
		assert mm.empty?
		assert_equal 0, mm.size

		mm.push :abc

		assert_equal [], mm[:abc]
		assert_equal 0, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.push :abc, 1, 2, '3', nil, false

		assert_equal [ 1, 2, '3', nil, false ], mm[:abc]
		assert_equal 5, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.push :def, *(0...10).to_a

		assert_equal [ 1, 2, '3', nil, false ], mm[:abc]
		assert_equal [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], mm[:def]
		assert_equal 15, mm.count
		assert_not mm.empty?
		assert_equal 2, mm.size
	end

	def test_shift

		mm = MultiMap.new

		assert_nil mm.shift

		mm.push :abc

		assert_equal [ :abc, [] ], mm.shift
	end

	def test_size

		test_length_and_size
	end

	def test_store

		mm = MultiMap.new

		assert_nil mm[:abc]
		assert_equal 0, mm.count
		assert mm.empty?
		assert_equal 0, mm.size

		mm.store :abc

		assert_equal [], mm[:abc]
		assert_equal 0, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.store :abc, 1, 2, '3', nil, false

		assert_equal [ 1, 2, '3', nil, false ], mm[:abc]
		assert_equal 5, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size

		mm.store :abc

		assert_equal [], mm[:abc]
		assert_equal 0, mm.count
		assert_not mm.empty?
		assert_equal 1, mm.size
	end

	def test_to_a

		mm = MultiMap.new

		mm.push :abc

		assert_equal [ :abc, [] ], mm.to_a

		mm.push :abc, 1, 2, 3, 4, 5

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5 ], mm.to_a

		mm.push :def

		assert_equal [ :abc, 1, :abc, 2, :abc, 3, :abc, 4, :abc, 5, :def, [] ], mm.to_a
	end

	def test_to_h

		mm = MultiMap.new

		mm.push :abc

		assert_equal ({ abc: [] }), mm.to_h

		mm.push :abc, 1, 2, 3, 4, 5

		assert_equal ({ abc: [ 1, 2, 3, 4, 5 ] }), mm.to_h

		mm.push :def

		assert_equal ({ abc: [ 1, 2, 3, 4, 5 ], def: [] }), mm.to_h
	end

	def test_values

		mm = MultiMap.new

		assert_equal [], mm.values

		mm.store :abc

		assert_equal [ [] ], mm.values

		mm.store :abc, 1, 2, '3', nil, false

		assert_equal [ [ 1, 2, '3', nil, false ] ], mm.values
	end
end

