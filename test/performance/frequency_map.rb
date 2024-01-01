#! /usr/bin/env ruby

$:.unshift File.join(File.dirname($0), *(['..'] * 2), 'lib')

require 'xqsr3/containers/frequency_map'

require 'benchmark'

include ::Xqsr3::Containers

Benchmark.bm do |bm|

	fm = FrequencyMap.new

	(0...100000000).each do |n|

		fm << (n % 4793)
	end

	bm.report('each       ') do

		fm.each do |k, freq|

		end
	end

	bm.report('each (by f)') do

		fm.each_by_frequency do |k, freq|

		end
	end
end

