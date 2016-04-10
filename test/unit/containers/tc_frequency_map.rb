#! /usr/bin/ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../lib')

require 'xqsr3/containers/frequency_map'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

include ::Xqsr3::Containers

class Test_Xqsr3_Containers_FrequencyMap < Test::Unit::TestCase

	def test_class_operator_subscript_1

		fm1 = FrequencyMap[]

		assert_equal 0, fm1.count
		assert fm1.empty?
		assert_equal 0, fm1.size
	end

	def test_class_operator_subscript_2

		fm2 = FrequencyMap[ abc: 1, def: 2 ]

		assert_equal 3, fm2.count
		assert_not fm2.empty?
		assert_equal 2, fm2.size
	end

	def test_class_operator_subscript_3

		fm3 = FrequencyMap[ [ [ :abc, 1 ], [ :def, 2 ] ] ]

		assert_equal 3, fm3.count
		assert_not fm3.empty?
		assert_equal 2, fm3.size

		assert_raise(::TypeError) { FrequencyMap[ [ [ :abc, 1 ], [ :def, '2' ] ] ] }
		assert_raise(::ArgumentError) { FrequencyMap[ [ [ :abc, 1 ], [ :def ] ] ] }
	end

	def test_class_operator_subscript_4

		fm3 = FrequencyMap[ [ :abc, 1, :def, 2 ] ]

		assert_equal 3, fm3.count
		assert_not fm3.empty?
		assert_equal 2, fm3.size

		fm4 = FrequencyMap[ [] ]

		assert_equal 0, fm4.count
		assert fm4.empty?
		assert_equal 0, fm4.size

		assert_raise(::ArgumentError) { FrequencyMap[ [ :abc, 1, :def, '2' ] ] }
		assert_raise(::ArgumentError) { FrequencyMap[ [ :abc, 1, :def ] ] }
	end

	def test_class_operator_subscript_5

		assert_raise(::ArgumentError) { FrequencyMap[ [ :abc ] ] }
	end

	def test_class_operator_subscript_6

		assert_raise(::TypeError) { FrequencyMap[ :abc ] }
	end

	def test_class_operator_subscript_7

		fm3 = FrequencyMap[ :abc, 1, :def, 2 ]

		assert_equal 3, fm3.count
		assert_not fm3.empty?
		assert_equal 2, fm3.size

		fm4 = FrequencyMap[]

		assert_equal 0, fm4.count
		assert fm4.empty?
		assert_equal 0, fm4.size

		assert_raise(::ArgumentError) { FrequencyMap[ :abc, 1, :def, '2' ] }
		assert_raise(::ArgumentError) { FrequencyMap[ :abc, 1, :def ] }
	end

	def test_class_operator_subscript_8

		fm = FrequencyMap::ByElement[ :abc, :def, :abc, 1, :ghi, 'jkl', :abc, 1, 'jkl' ]

		assert_equal 9, fm.count
		assert_not fm.empty?
		assert_equal 5, fm.size

		assert_equal 3, fm[:abc]
		assert_equal 1, fm[:def]
		assert_equal 2, fm[1]
		assert_equal 1, fm[:ghi]
		assert_equal 2, fm['jkl']
	end

	def test_instance_operator_equals

		fm1 = FrequencyMap.new
		fm2 = FrequencyMap.new

		assert fm1 == fm1
		assert fm2 == fm2
		assert fm1 == fm2

		fm1 << :abc << :def

		assert fm1 == fm1
		assert fm2 == fm2
		assert_not fm1 == fm2

		fm2 << :def << :abc

		assert fm1 == fm1
		assert fm2 == fm2
		assert fm1 == fm2

		# can compare against Hash

		fm1 = FrequencyMap.new
		fm2 = Hash.new

		assert fm1 == fm1
		assert fm2 == fm2
		assert fm1 == fm2

		fm1 << :abc << :def

		assert_not fm1 == fm2
		assert fm1 == fm1
		assert fm2 == fm2

		fm2[:abc] = 1
		fm2[:def] = 1

		assert fm1 == fm1
		assert fm2 == fm2
		assert fm1 == fm2
	end

	def test_instance_operator_subscript

		fm = FrequencyMap.new

		assert_nil fm[:abc]
		assert_nil fm[:def]

		fm << :abc

		assert_equal 1, fm[:abc]
		assert_nil fm[:def]

		fm << :def << :def << :def

		assert_equal 1, fm[:abc]
		assert_equal 3, fm[:def]
	end

	def test_instance_operator_subscript_assign

		fm = FrequencyMap.new

		fm[:abc] = 1

		assert_equal 1, fm[:abc]

		fm[:def] = 3

		assert_equal 3, fm[:def]

		fm[:abc] = 2

		assert_equal 2, fm[:abc]
	end

	def test_assoc

		fm = FrequencyMap.new

		assert_nil fm.assoc :abc

		fm << :abc

		assert_equal [:abc, 1], fm.assoc(:abc)

		fm << :abc

		assert_equal [:abc, 2], fm.assoc(:abc)
	end

	def test_clear

		fm = FrequencyMap.new

		assert_nil fm['abc']
		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size

		fm << 'abc'

		assert_not_nil fm['abc']
		assert_equal 1, fm.count
		assert_not fm.empty?
		assert_equal 1, fm.size

		fm.clear

		assert_nil fm['abc']
		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size
	end

	def test_count_and_delete

		fm = FrequencyMap.new

		assert_equal 0, fm.count

		fm << :abc

		assert_equal 1, fm.count

		fm << :abc

		assert_equal 2, fm.count

		fm << :def

		assert_equal 3, fm.count

		fm.delete :ghi

		assert_equal 3, fm.count

		fm.delete :abc

		assert_equal 1, fm.count
	end

	def test_count

		test_count_and_delete
	end

	def test_default

		fm = FrequencyMap.new

		assert_nil fm.default
	end

	def test_delete

		test_count
	end

	def test_dup

		fm1 = FrequencyMap.new
		fm2 = fm1.dup

		assert_equal fm1, fm2
		assert_eql fm1, fm2

		fm1 << :abc

		assert_not_equal fm1, fm2
		assert_not_eql fm1, fm2

		fm3 = fm1.dup

		assert_equal fm1, fm3
		assert_eql fm1, fm3
	end

	def test_each

		fm = FrequencyMap.new

		fm << :def
		fm << :abc << :abc << :abc << :abc
		fm << :ghi << :ghi

		r = []

		fm.each do |k, v|

			r << [k, v]
		end

		r.sort! { |a, b| a[0] <=> b[0] }

		assert_equal 3, r.size
		assert_equal [:abc, 4], r[0]
		assert_equal [:def, 1], r[1]
		assert_equal [:ghi, 2], r[2]
	end

	def test_each_by_frequency

		fm = FrequencyMap.new

		fm << :def
		fm << :abc << :abc << :abc << :abc
		fm << :ghi << :ghi

		r = []

		fm.each_by_frequency do |k, v|

			r << [k, v]
		end

		assert_equal 3, r.size
		assert_equal [:abc, 4], r[0]
		assert_equal [:ghi, 2], r[1]
		assert_equal [:def, 1], r[2]
	end

	def each_value

		fm = FrequencyMap.new

		fm << :def
		fm << :abc << :abc << :abc << :abc
		fm << :ghi << :ghi

		r = []

		fm.each_value do |v|

			r << [v]
		end

		r.sort!

		assert_equal 3, r.size
		assert_equal [1, 2, 4], r
	end

	def each_with_index

		fm = FrequencyMap.new

		fm << :def
		fm << :abc << :abc << :abc << :abc
		fm << :ghi << :ghi

		fm.each_with_index do |k, v, index|

			case	index
			when	0
				assert_equal :abc, k
				assert_equal 2, v
			when	1
				assert_equal :def, k
				assert_equal 1, v
			else
				assert false, "should never get here"
			end
		end
	end

	def test_empty

		fm = FrequencyMap.new

		assert fm.empty?

		fm << :def

		assert_not fm.empty?
		assert_equal 1, fm.size
		assert_equal 1, fm.count

		fm.clear

		assert fm.empty?

		assert_equal 0, fm.size
		assert_equal 0, fm.count
	end

	def test_eql

		fm1 = FrequencyMap.new
		fm2 = FrequencyMap.new

		assert fm1.eql? fm1
		assert fm2.eql? fm2
		assert fm1.eql? fm2

		fm1 << :abc << :def

		assert fm1.eql? fm1
		assert fm2.eql? fm2
		assert_not fm1.eql? fm2

		fm2 << :def << :abc

		assert fm1.eql? fm1
		assert fm2.eql? fm2
		assert fm1.eql? fm2

		assert_equal 2, fm1.size
		assert_equal 2, fm1.count
	end

	def test_fetch

		fm = FrequencyMap.new

		assert_raise(::KeyError) { fm.fetch(:does_not_exist) }
		assert_equal 2, fm.fetch(:does_not_exist, 2)
		assert_raise(::TypeError) { fm.fetch(:does_not_exist, :wrong_type) }
		assert_equal 33, fm.fetch(:does_not_exist) { |k| 33 }
		assert_equal 34, fm.fetch(:does_not_exist) { 34 }


		fm << :abc << :abc << :abc

		assert_equal 3, fm.fetch(:abc)
		assert_equal 3, fm.fetch(:abc, 1)
		assert_equal 3, (fm.fetch(:abc) { |k| 33 })

		assert_equal 1, fm.size
		assert_equal 3, fm.count
	end

	def test_flatten

		fm = FrequencyMap.new

		assert_equal [], fm.flatten

		fm << :def

		assert_equal [:def, 1], fm.flatten

		fm << :def

		assert_equal [:def, 2], fm.flatten

		fm << :abc

		assert_equal [:def, 2, :abc, 1], fm.flatten
	end

	def test_has_key?

		fm = FrequencyMap.new

		assert_not fm.has_key? nil
		assert_not fm.has_key? :abc
		assert_not fm.has_key? 'abc'

		fm << :abc

		assert_not fm.has_key? nil
		assert fm.has_key? :abc
		assert_not fm.has_key? 'abc'

		fm << 'abc'

		assert_not fm.has_key? nil
		assert fm.has_key? :abc
		assert fm.has_key? 'abc'
	end

	def test_has_value?

		fm = FrequencyMap.new

		assert_not fm.has_value? 1
		assert_not fm.has_value? 2
		assert_raise(::TypeError) { fm.has_value? 1.1 }

		fm << :abc

		assert fm.has_value? 1
		assert_not fm.has_value? 2

		fm << :abc

		assert_not fm.has_value? 1
		assert fm.has_value? 2
	end

	def test_key

		fm = FrequencyMap.new

		assert_nil fm.key 1
		assert_nil fm.key 2
		assert_raise(::TypeError) { fm.key 1.1 }

		fm << :abc

		assert_equal :abc, fm.key(1)
		assert_not_equal :abc, fm.key(2)

		fm << :abc

		assert_not_equal :abc, fm.key(1)
		assert_equal :abc, fm.key(2)
	end

	def test_length_and_size

		fm = FrequencyMap.new

		assert_equal 0, fm.length
		assert_equal 0, fm.size

		fm << :abc

		assert_equal 1, fm.length
		assert_equal 1, fm.size

		fm << :abc

		assert_equal 1, fm.length
		assert_equal 1, fm.size

		fm << :def

		assert_equal 2, fm.length
		assert_equal 2, fm.size

		fm.delete :abc

		assert_equal 1, fm.length
		assert_equal 1, fm.size
	end

	def test_length

		test_length_and_size
	end

	def test_merge

		fm1 = FrequencyMap.new
		fm2 = FrequencyMap.new

		fm1 << :abc << :def << :ghi << :ghi
		fm2 << :abc <<         :ghi         << :jkl << :jkl

		fm3 = fm1.merge fm2

		assert_equal 8, fm3.count
		assert_equal 4, fm3.size

		assert_equal 2, fm3[:abc]
		assert_equal 1, fm3[:def]
		assert_equal 3, fm3[:ghi]
		assert_equal 2, fm3[:jkl]
	end

	def test_merge!

		fm1 = FrequencyMap.new
		fm2 = FrequencyMap.new

		fm1 << :abc << :def << :ghi << :ghi
		fm2 << :abc <<         :ghi         << :jkl << :jkl

		fm1.merge! fm2

		assert_equal 8, fm1.count
		assert_equal 4, fm1.size

		assert_equal 2, fm1[:abc]
		assert_equal 1, fm1[:def]
		assert_equal 3, fm1[:ghi]
		assert_equal 2, fm1[:jkl]
	end

	def test_push

		fm = FrequencyMap.new

		assert fm.empty?

		fm.push :abc
		fm.push :def, 2
		fm.push :ghi, 1
		fm.push :ghi, 0
		fm.push :ghi, 1

		assert_equal 5, fm.count
		assert_not fm.empty?
		assert_equal 3, fm.size

		assert_equal 1, fm[:abc]
		assert_equal 2, fm[:def]
		assert_equal 2, fm[:ghi]
	end

	def test_shift

		fm = FrequencyMap.new

		assert_nil fm.shift


		fm << :abc

		assert_equal 1, fm.count
		assert_not fm.empty?
		assert_equal 1, fm.size

		r = fm.shift

		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size

		assert_equal [:abc, 1], r


		fm << :def << :def

		assert_equal 2, fm.count
		assert_not fm.empty?
		assert_equal 1, fm.size

		r = fm.shift

		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size

		assert_equal [:def, 2], r


		fm << :abc << :def << :def

		assert_equal 3, fm.count
		assert_not fm.empty?
		assert_equal 2, fm.size

		r = fm.shift

		assert_equal 2, fm.count
		assert_not fm.empty?
		assert_equal 1, fm.size

		assert_equal [:abc, 1], r

		r = fm.shift

		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size

		assert_equal [:def, 2], r
	end

	def test_size

		test_length_and_size
	end

	def test_store

		fm = FrequencyMap.new

		assert_equal 0, fm.count
		assert fm.empty?
		assert_equal 0, fm.size

		fm.store :abc, 1

		assert_equal 1, fm.count
		assert_not fm.empty?
		assert_equal 1, fm.size

		fm.store :def, 2

		assert_equal 3, fm.count
		assert_not fm.empty?
		assert_equal 2, fm.size

		assert_raise(::TypeError) { fm.store :ghi, :blah }
	end

	def test_to_a

		fm = FrequencyMap.new

		assert_equal [], fm.to_a

		fm << :abc << :abc

		assert_equal [[:abc, 2]], fm.to_a

		fm << :def << :def << :def

		assert_equal [[:abc, 2], [:def, 3]], fm.to_a
	end

	def test_to_h

		fm = FrequencyMap.new

		assert_equal Hash.new, fm.to_h

		fm << :abc << :abc

		assert_equal ({:abc => 2}), fm.to_h

		fm << :def << :def << :def

		assert_equal ({:abc => 2, :def => 3}), fm.to_h
	end

	def test_values

		fm = FrequencyMap.new

		assert_equal [], fm.values

		fm << :abc << :def << :def << :ghi

		assert_equal [1, 2, 1], fm.values
	end
end

