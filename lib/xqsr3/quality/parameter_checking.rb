
# ######################################################################## #
# File:         lib/xqsr3/quality/parameter_checking.rb
#
# Purpose:      Definition of the ParameterChecking module
#
# Created:      12th February 2015
# Updated:      21st March 2018
#
# Home:         http://github.com/synesissoftware/xqsr3
#
# Author:       Matthew Wilson
#
# Copyright (c) 2015-2018, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################## #


# ##########################################################
# ::Xqsr3::Quality::ParameterChecking

=begin
=end

module Xqsr3
module Quality

# Inclusion module that creates class and instance methods +check_parameter+
# that may be used to check parameter values and types
#
module ParameterChecking

	private
	module Util_ # :nodoc:

		def self.join_with_or a

			case a.size
			when 1

				a[0]
			when 2

				"#{a[0]} or #{a[1]}"
			else

				"#{a[0...-1].join(', ')}, or #{a[-1]}"
			end
		end
	end # module Util_
	public

	def self.included base

		base.extend self
	end

	private
	# Check a given parameter (value=+value+, name=+name+) for type and value
	#
	# @param +value+:: the parameter whose value and type is to be checked
	# @param +name+:: (::String, ::Symbol) the name of the parameter to be
	#         checked
	# @param +options+:: (::Hash) options that moderate the behaviour
	#
	# @option +:allow_nil+:: (boolean) The +value+ must not be +nil+ unless
	#          this option is true
	# @option +:nil+:: an alias for +:allow_nil+
	# @option +:types+:: (::Array) An array of types one of which +value+
	#          must be (or must be derived from). One of these types may be
	#          an array of types, in which case +value+ may be an array that
	#          must consist wholly of those types
	# @option +:type+:: (::Class) A single type parameter, used only if
	#          +:types+ is not specified
	# @option +:values+:: (::Array) an array of values one of which +value+
	#          must be
	# @option +:responds_to+:: (::Array) An array of symbols specifying all
	#          messages to which the parameter will respond
	# @option +:reject_empty+:: (boolean) requires value to respond to
	#          +empty?+ message and to do so with false, unless +nil+
	# @option +:require_empty+:: (boolean) requires value to respond to
	#          +empty?+ message and to do so with true, unless +nil+
	# @option +:nothrow+:: (boolean) causes failure to be indicated by a
	#          +nil+ return rather than a thrown exception
	# @option +:message+:: (::String) specifies a message to be used in any
	#          thrown exception, which suppresses internal message
	#          preparation
	# @option +:treat_as_option+:: (boolean) If true, the value will be
	#          treated as an option when reporting check failure
	#
	# This method is private, because it should only be used within methods
	def check_parameter value, name, options = {}, &block

		Util_.check_parameter value, name, options, &block
	end

	# @see check_parameter
	#
	# @note This is obsolete, and will be removed in a future version.
	# Please use +check_parameter+ instead
	def check_param value, name, options = {}, &block

		Util_.check_parameter value, name, options, &block
	end

	# Specific form of the +check_parameter()+ that is used to check
	# options, taking instead the hash and the key
	#
	# @param +h+:: (::Hash) The options hash from which the named element is
	#         to be tested. May not be +nil+
	# @param +name+:: (::String, ::Symbol) The options key name. May not be
	#         +nil+
	# @param +options+:: (::Hash) options that moderate the behaviour in the
	#         same way as for +check_parameter()+ except that the
	#         +:treat_as_option+ option (with the value +true+) is merged in
	#         before calling +check_parameter()+
	#
	def check_option h, name, options = {}, &block

		Util_.check_parameter h[name], name, options.merge({ treat_as_option: true }), &block
	end

	public
	# Check a given parameter (value=+value+, name=+name+) for type and value
	#
	# @param +value+:: the parameter whose value and type is to be checked
	# @param +name+:: the name of the parameter to be checked
	# @param +options+:: options
	#
	# @option +:allow_nil+:: (boolean) The +value+ must not be +nil+ unless
	#          this option is true
	# @option +:nil+:: an alias for +:allow_nil+
	# @option +:types+:: (::Array) An array of types one of which +value+ must
	#          be (or must be derived from). One of these types may be an
	#          array of types, in which case +value+ may be an array that
	#          must consist wholly of those types
	# @option +:type+:: (::Class) A single type parameter, used only if
	#          +:types+ is not specified
	# @option +:values+:: (::Array) an array of values one of which +value+
	#          must be
	# @option +:responds_to+:: (::Array) An array of symbols specifying all
	#          messages to which the parameter will respond
	# @option +:reject_empty+:: (boolean) requires value to respond to +empty?+
	#          message and to do so with false, unless +nil+
	# @option +:require_empty+:: (boolean) requires value to respond to
	#          +empty?+ message and to do so with true, unless +nil+
	# @option +:nothrow+:: (boolean) causes failure to be indicated by a +nil+
	#          return rather than a thrown exception
	# @option +:message+:: (boolean) specifies a message to be used in any
	#          thrown exception, which suppresses internal message
	#          preparation
	# @option +:treat_as_option+:: (boolean) If true, the value will be
	#          treated as an option when reporting check failure
	#
	def self.check_parameter value, name, options = {}, &block

		Util_.check_parameter value, name, options, &block
	end

	# @see check_parameter
	#
	# @note This is obsolete, and will be removed in a future version.
	# Please use +check_parameter+ instead
	def self.check_param value, name, options = {}, &block

		Util_.check_parameter value, name, options, &block
	end

	private
	def Util_.check_parameter value, name, options, &block

		failed_check	=	false
		options			||=	{}
		message			=	options[:message]
		treat_as_option	=	options[:treat_as_option]
		return_value	=	value
		param_s			=	treat_as_option	? 'option' : 'parameter'

		warn "#{self}::check_parameter: invoked with non-string/non-symbol name: name.class=#{name.class}" unless name && [ ::String, ::Symbol ].any? { |c| name.is_a?(c) }

		if treat_as_option

			case name
			when ::String
				name = ':' + name if ':' != name[0]
			when ::Symbol
				name = ':' + name.to_s
			else
			end
		end


		# nil check

		if value.nil? && !options[:allow_nil]

			failed_check	=	true

			unless options[:nothrow]

				unless message

					if name.nil?

						message	=	"#{param_s} may not be nil"
					else

						message	=	"#{param_s} '#{name}' may not be nil"
					end
				end

				raise ArgumentError, message
			end
		end

		# check type(s)

		unless value.nil?

			# types

			types		=	options[:types] || []
			if options.has_key? :type

				types	<<	options[:type] if types.empty?
			end
			types		=	[value.class] if types.empty?

			warn "#{self}::check_parameter: options[:types] of type #{types.class} - should be #{::Array}" unless types.is_a?(Array)
			warn "#{self}::check_parameter: options[:types] - '#{options[:types]}' - should contain only classes or arrays of classes" if types.is_a?(::Array) && !types.all? { |c| ::Class === c || (::Array === c && c.all? { |c2| ::Class === c2 }) }

			unless types.any? do |t|

					case t
					when ::Class

						# the (presumed) scalar argument is of type t?
						value.is_a?(t)
					when ::Array

						# the (presumed) vector argument's elements are the
						# possible types
						value.all? { |v| t.any? { |t2| v.is_a?(t2) }} if ::Array === value
					end
				end

				failed_check	=	true

				unless options[:nothrow]

					unless message

						s_name		=	name.is_a?(String) ? "'#{name}' " : ''

						types_0		=	types.select { |t| ::Class === t }.uniq
						types_ar	=	types.select { |t| ::Array === t }.flatten.uniq

						if types_ar.empty?

							s_types_0	=	Util_.join_with_or types_0

							message		=	"#{param_s} #{s_name}(#{value.class}) must be an instance of #{s_types_0}"
						elsif types_0.empty?

							s_types_ar	=	Util_.join_with_or types_ar

							message		=	"#{param_s} #{s_name}(#{value.class}) must be an array containing instance(s) of #{s_types_ar}"
						else

							s_types_0	=	Util_.join_with_or types_0

							s_types_ar	=	Util_.join_with_or types_ar

							message		=	"#{param_s} #{s_name}(#{value.class}) must be an instance of #{s_types_0}, or an array containing instance(s) of #{s_types_ar}"
						end
					end

					raise TypeError, message
				end
			end


			# messages

			messages	=	options[:responds_to] || []

			warn "#{self}::check_parameter: options[:responds_to] of type #{messages.class} - should be #{::Array}" unless messages.is_a?(Array)
			warn "#{self}::check_parameter: options[:responds_to] should contain only symbols or strings" if messages.is_a?(::Array) && !messages.all? { |m| ::Symbol === m || ::String === m }

			messages.each do |m|

				unless value.respond_to? m

					s_name		=	name.is_a?(String) ? "'#{name}' " : ''

					raise TypeError, "#{param_s} #{s_name}(#{value.class}) must respond to the '#{m}' message"
				end
			end

		end

		# reject/require empty?

		if options[:reject_empty]

			warn "#{self}::check_parameter: value '#{value}' of type #{value.class} does not respond to empty?" unless value.respond_to? :empty?

			if value.empty?

				failed_check	=	true

				unless options[:nothrow]

					unless message
						s_name		=	name.is_a?(String) ? "'#{name}' " : ''

						message		=	"#{param_s} #{s_name}must not be empty"
					end

					raise ArgumentError, message
				end
			end
		end

		if options[:require_empty]

			warn "#{self}::check_parameter: value '#{value}' of type #{value.class} does not respond to empty?" unless value.respond_to? :empty?

			unless value.empty?

				failed_check	=	true

				unless options[:nothrow]

					unless message
						s_name		=	name.is_a?(String) ? "'#{name}' " : ''

						message		=	"#{param_s} #{s_name}must be empty"
					end

					raise ArgumentError, message
				end
			end
		end

		# check value(s)

		unless value.nil?

			values	=	options[:values] || [ value ]

			warn "#{self}::check_parameter: options[:values] of type #{values.class} - should be #{::Array}" unless values.is_a?(Array)

			found	=	false

			values.each do |v|

				if ::Range === v && !(::Range === value) && v.cover?(value)

					found = true
					break
				end

				if value == v

					found = true
					break
				end
			end

			unless found

				failed_check	=	true

				unless options[:nothrow]

					unless message
						s_name		=	name.is_a?(String) ? "'#{name}' " : ''

						message		=	"#{param_s} #{s_name}value '#{value}' not found equal/within any of required values or ranges"
					end

					if value.is_a?(::Numeric)

						raise RangeError, message
					else

						raise ArgumentError, message
					end
				end
			end
		end

		# run block

		if value and block

			warn "#{self}::check_parameter: block arity must be 1 or 2" unless (1..2).include? block.arity

			r	=	nil

			begin

				if 1 == block.arity

					r = block.call(value)
				else

					r = block.call(value, options)
				end

			rescue StandardError => x

				xmsg	=	x.message || ''

				if xmsg.empty?

					xmsg	||=	message

					if xmsg.empty?

						s_name	=	name.is_a?(String) ? "'#{name}' " : ''
						xmsg	=	"#{param_s} #{s_name}failed validation against caller-supplied block"
					end

					raise $!, xmsg, $!.backtrace
				end

				raise
			end

			if r.is_a?(::Exception)

				# An exception returned from the block, so raise it, with
				# its message or a custom message

				x		=	r
				xmsg	=	x.message || ''

				if xmsg.empty?

					xmsg	||=	message

					if xmsg.empty?

						s_name	=	name.is_a?(String) ? "'#{name}' " : ''
						xmsg	=	"#{param_s} #{s_name}failed validation against caller-supplied block"
					end

					raise x, xmsg
				end

				raise x

			elsif !r

				failed_check	=	true

				unless options[:nothrow]

					s_name	=	name.is_a?(String) ? "'#{name}' " : ''
					xmsg	=	"#{param_s} #{s_name}failed validation against caller-supplied block"

					if value.is_a?(::Numeric)

						raise RangeError, xmsg
					else

						raise ArgumentError, xmsg
					end
				end

			elsif r.is_a?(::TrueClass)

				;
			else

				return_value	=	r
			end
		end

		failed_check ? nil : return_value
	end

end # module ParameterChecking

end # module Quality
end # module Xqsr3

# ############################## end of file ############################# #


