#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '../../../../lib')

require 'xqsr3/xml/utilities/compare'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

class Test_Xqsr3_XML_Utilities_Compare < Test::Unit::TestCase

	include ::Xqsr3::XML::Utilities::Compare

	def test_compare_nil

		assert xml_compare(nil, nil).succeeded

		assert_false xml_compare('', nil).succeeded
		assert_false xml_compare(nil, '').succeeded

		assert xml_compare('', nil, equate_nil_and_empty: true).succeeded
		assert xml_compare(nil, '', equate_nil_and_empty: true).succeeded
	end

	def test_compare_empty

		assert xml_compare('', '').succeeded

		assert_false xml_compare('<abc/>', '').succeeded
		assert_false xml_compare('', '<abc/>').succeeded
	end

	def test_compare_one_level_1

		assert xml_compare('<abc/>', '<abc/>').succeeded
		assert xml_compare('<abc/>', '<abc></abc>').succeeded
		assert_false xml_compare('<abc/>', '<def/>').succeeded
	end

	def test_compare_two_level_1

		assert xml_compare('<parent><child1></child1></parent>', '<parent><child1></child1></parent>').succeeded
		assert xml_compare('<parent><child1/></parent>', '<parent><child1></child1></parent>').succeeded

		r = xml_compare('<parent><child1/></parent>', '<parent><child2/></parent>')

		assert_false r.succeeded
	end

	def test_compare_two_level_2

		lhs		=	<<END_OF_lhs
<parent>
 <child1/>
</parent>
END_OF_lhs
		rhs		=	<<END_OF_rhs
<parent>
 <child1>
 </child1>
</parent>
END_OF_rhs

		r		=	xml_compare(lhs, rhs, normalize_whitespace: false)

		assert_false r.succeeded, "#{r.details}"

		r		=	xml_compare(lhs, rhs, normalize_whitespace: true)

		assert r.succeeded, "#{r.details}"
	end

end

