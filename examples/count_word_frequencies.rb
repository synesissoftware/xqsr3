#! /usr/bin/env ruby

# examples/count_word_frequencies.rb

require 'xqsr3/containers/frequency_map'

include Xqsr3::Containers


puts "Analyse DATA words via FrequencyMap"
puts

data = DATA.read
data = data.gsub(/\n/, ' ')
words = data.split


puts "1. Manually (showing items with 2+ occurrences):"

fm = FrequencyMap.new

words.each { |word| fm << word }

fm.each_by_frequency do |word, frequency|

	next if 1 == frequency

	$stdout.puts "\t#{word}\t#{frequency}"
end
puts


puts "2. Via ByElement (showing items with 2+ occurrences):"

fm = FrequencyMap::ByElement[*words]

fm.each_by_frequency do |word, frequency|

	next if 1 == frequency

	$stdout.puts "\t#{word}\t#{frequency}"
end
puts



__END__
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

