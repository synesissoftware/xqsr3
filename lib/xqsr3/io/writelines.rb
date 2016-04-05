# ######################################################################### #
# File:         xqsr3/io/writelines.rb
#
# Purpose:      Adds a writelines() method to the IO module
#
# Created:      13th April 2007
# Updated:      5th April 2016
#
# Author:       Matthew Wilson
#
# Copyright (c) 2007-2016, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################### #

# ##########################################################
# Xqsrt3::IO

module Xqsr3
module IO

	private
	module Constants_

		NUMBER_OF_LINES_TO_EXAMINE	=	20

	end # module Constants_

	private

	def self.write_to_target_ target, contents, line_separator, column_separator
$stderr.puts "#{self.class}.write_to_target_(target(#{target.class})='#{target}', contents(#{contents.class})='#{contents}', line_separator(#{line_separator.class})='#{line_separator}', column_separator=(#{column_separator.class})='#{column_separator}')" if $DEBUG
		if contents.instance_of? ::Hash

			contents.each do |k, v|

				target << "#{k}#{column_separator}#{v}#{line_separator}"
			end
		else

			contents.each do |element|

				target << "#{element}#{line_separator}"
			end
		end

		contents.size
	end

	def self.deduce_line_separator_ contents, eol_lookahead_limit

		if contents.instance_of? ::Hash

			contents.each_with_index do |k, v, index|

				if eol_lookahead_limit == index

					break
				else

					return '' if v.to_s.include? "\n"
					return '' if k.to_s.include? "\n"
				end
			end
		else

			contents.each_with_index do |element, index|

				if eol_lookahead_limit == index

					break
				else

					return '' if element.to_s.include? "\n"
				end
			end
		end

		"\n"
	end

	public

	# Writes the contents to the target, subject to the options
	# 
	def self.writelines target, contents, options = {}

		# process parameters

		if contents.instance_of? String

			if contents.include? "\n"

				contents = contents.split(/\r?\n/, -1)
			else

				contents = [ contents ]
			end
		end

		options				||=	{}
		eol_lookahead_limit	=	options[:eol_lookahead_limit] || Constants_::NUMBER_OF_LINES_TO_EXAMINE
		column_separator	=	options[:column_separator] || ''
		line_separator		=	options[:line_separator] || self.deduce_line_separator_(contents, eol_lookahead_limit)

		if not contents.kind_of? ::Enumerable and not contents.instance_of? ::Hash

			raise ArgumentError, "writelines() must be passed a #{::String}, or a #{::Hash}, or an #{::Enumerable} (or derived)"
		end

		# do the writing

		if ::String === target

			File.open(target, "w") do |io|

				self.write_to_target_ io, contents, line_separator, column_separator
			end
		else

			self.write_to_target_ target, contents, line_separator, column_separator
		end
	end # writelines
end # module IO
end # module Xqsr3

# ############################## end of file ############################# #

