
# ######################################################################## #
# File:     lib/xqsr3/quality/parameter_checking.rb
#
# Purpose:  Definition of the ParameterChecking module
#
# Created:  12th February 2015
# Updated:  29th August 2025
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2025, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2016-2019, Matthew Wilson and Synesis Software
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
# * Neither the names of the copyright holders nor the names of its
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


=begin
=end

module Xqsr3
module Quality

  # Inclusion module that creates class and instance methods +check_option()+
  # and +check_parameter()+ that may be used to check option/parameter values
  # and types.
  #
  module ParameterChecking

    private
    # @!visibility private
    module Util_ # :nodoc: all

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

      module Constants # :nodoc:

        RECOGNISED_OPTION_NAMES = %w{

          allow_nil
          ignore_case
          message
          nil
          nothrow
          reject_empty
          require_empty
          responds_to
          strip_str_whitespace
          treat_as_option
          type
          types
          values
        }.map { |v| v.to_sym }

      end # module Constants
    end # module Util_
    public

    def self.included base # :nodoc:

      base.extend self
    end

    private
    # Check a given parameter (value=+value+, name=+name+) for type and value
    #
    # === Signature
    #
    # * *Parameters:*
    #   - +value+ the parameter whose value and type is to be checked;
    #   - +name+ (+String+, +Symbol+) the name of the parameter to be checked;
    #   - +options+ (+Hash+) Options that control the behaviour of the method;
    #
    # * *Options:*
    #   - +:allow_nil+ (boolean) The +value+ must not be +nil+ unless this option is true;
    #   - +:nil+ an alias for +:allow_nil+;
    #   - +:ignore_case+ (boolean) When +:values+ is specified, comparisons of strings, or arrays of strings, will be carried out in a case-insensitive manner;
    #   - +:types+ (+Array+) An array of types one of which +value+ must be (or must be derived from). One of these types may be an array of types, in which case +value+ may be an array that must consist wholly of those types;
    #   - +:type+ (+Class+) A single type parameter, used only if +:types+ is not specified;
    #   - +:values+ (+Array+) an array of values one of which +value+ must be;
    #   - +:responds_to+ (+Array+) An array of symbols specifying all messages to which the parameter will respond;
    #   - +:reject_empty+ (boolean) requires value to respond to +empty?+ message and to do so with false, unless +nil+;
    #   - +:require_empty+ (boolean) requires value to respond to +empty?+ message and to do so with true, unless +nil+;
    #   - +:nothrow+ (boolean) causes failure to be indicated by a +nil+ return rather than a thrown exception;
    #   - +:message+ (+String+) specifies a message to be used in any thrown exception, which suppresses internal message preparation;
    #   - +:strip_str_whitespace+ (boolean) If +value+ is a string (as determined by responding to +to_str+ message), then it will be stripped - leading and trailing whitespace removed - before any processing;
    #   - +:treat_as_option+ (boolean) If true, the value will be treated as an option when reporting check failure;
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
    # === Signature
    #
    # * *Parameters:*
    #   - +h+ (+Hash+) The options hash from which the named element is to be tested. May not be +nil+;
    #   - +name+ (+String+, +Symbol+, +[ String, Symbol ]+) The options key name, or an array of names. May not be +nil+;
    #   - +options+ (+Hash+) Options that control the behaviour of the method in the same way as for +check_parameter()+ except that the +:treat_as_option+ option (with the value +true+) is merged in before calling +check_parameter()+;
    #
    # * *Options:*
    def check_option h, name, options = {}, &block

      Util_.check_option h, name, options, &block
    end

    public
    # Check a given parameter (value=+value+, name=+name+) for type and value
    #
    # === Signature
    #
    # * *Parameters:*
    #   - +value+ the parameter whose value and type is to be checked;
    #   - +name+ the name of the parameter to be checked;
    #   - +options+ (+Hash+) Options that control the behaviour of the method;
    #
    # * *Options:*
    #   - +:allow_nil+ (boolean) The +value+ must not be +nil+ unless this option is true;
    #   - +:nil+ an alias for +:allow_nil+;
    #   - +:ignore_case+ (boolean) When +:values+ is specified, comparisons of strings, or arrays of strings, will be carried out in a case-insensitive manner;
    #   - +:types+ (+Array+) An array of types one of which +value+ must be (or must be derived from). One of these types may be an array of types, in which case +value+ may be an array that must consist wholly of those types;
    #   - +:type+ (+Class+) A single type parameter, used only if +:types+ is not specified;
    #   - +:values+ (+Array+) an array of values one of which +value+ must be;
    #   - +:responds_to+ (+Array+) An array of symbols specifying all messages to which the parameter will respond;
    #   - +:reject_empty+ (boolean) requires value to respond to +empty?+ message and to do so with false, unless +nil+;
    #   - +:require_empty+ (boolean) requires value to respond to +empty?+ message and to do so with true, unless +nil+;
    #   - +:nothrow+ (boolean) causes failure to be indicated by a +nil+ return rather than a thrown exception;
    #   - +:message+ (boolean) specifies a message to be used in any thrown exception, which suppresses internal message preparation;
    #   - +:treat_as_option+ (boolean) If true, the value will be treated as an option when reporting check failure;
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

    # Specific form of the +check_parameter()+ that is used to check
    # options, taking instead the hash and the key
    #
    # === Signature
    #
    # * *Parameters:*
    #   - +h+ (+Hash+) The options hash from which the named element is to be tested. May not be +nil+;
    #   - +name+ (+String+, +Symbol+, +[ String, Symbol ]+) The options key name, or an array of names. May not be +nil+;
    #   - +options+ (+Hash+) Options that control the behaviour of the method in the same way as for +check_parameter()+ except that the +:treat_as_option+ option (with the value +true+) is merged in before calling +check_parameter()+;
    #
    # * *Options:*
    def self.check_option h, name, options = {}, &block

      Util_.check_option h, name, options, &block
    end

    private
    def Util_.check_option h, names, options = {}, &block

      warn "#{self}::#{__method__}: given parameter h - value '#{h.inspect}' - must be a #{::Hash} but is a #{h.class}" unless ::Hash === h

      case names
      when ::Array

        allow_nil = options[:allow_nil] || options[:nil]

        # find the first item whose name is in the hash ...

        found_name = names.find { |name| h.has_key?(name) }

        if found_name.nil? && allow_nil

          return nil
        end

        # ... or use the first (just to get a name for reporting)

        found_name ||= names[0]

        Util_.check_parameter h[found_name], found_name, options.merge({ treat_as_option: true }), &block
      else

        name = names

        Util_.check_parameter h[name], name, options.merge({ treat_as_option: true }), &block
      end
    end

    def Util_.check_parameter value, name, options, &block

      if $DEBUG

        unrecognised_option_names = options.keys - Util_::Constants::RECOGNISED_OPTION_NAMES

        unless unrecognised_option_names.empty?

          warn_msg = "#{self}::check_parameter: the following options are not recognised:"

          unrecognised_option_names.each { |n| warn_msg += "\n\t'#{n}'" }

          warn warn_msg
        end
      end

      # strip whitespace

      if !value.nil? && options[:strip_str_whitespace]

        if value.respond_to? :to_str

          value = value.to_str.strip
        else

          warn "#{self}::#{__method__}: options[:strip_str_whitespace] specified but value - '#{value}' (#{value.class}) - does not respond to to_str" unless value.respond_to? :to_str
        end
      end


      failed_check      =   false
      options           ||= {}
      message           =   options[:message]
      treat_as_option   =   options[:treat_as_option]
      param_s           =   treat_as_option ? 'option' : 'parameter'
      allow_nil         =   options[:allow_nil] || options[:nil]

      warn "#{self}::check_parameter: invoked with non-string/non-symbol name: name.class=#{name.class}" unless name && [ ::String, ::Symbol ].any? { |c| name.is_a?(c) }

      if treat_as_option

        case name
        when ::String

          ;
        when ::Symbol

          name = ':' + name.to_s
        else
        end
      end


      # nil check

      if value.nil? && !allow_nil

        failed_check = true

        unless options[:nothrow]

          unless message

            if name.nil?

              message = "#{param_s} may not be nil"
            else

              message = "#{param_s} '#{name}' may not be nil"
            end
          end

          raise ArgumentError, message
        end
      end

      # check type(s)

      unless value.nil?

        # types

        types = options[:types] || []
        if options.has_key? :type

          types << options[:type] if types.empty?
        end
        types = [value.class] if types.empty?
        types = types.map { |type| :boolean == type ? [ ::TrueClass, ::FalseClass ] : type }.flatten if types.include?(:boolean)

        warn "#{self}::check_parameter: options[:types] of type #{types.class} - should be #{::Array}" unless types.is_a?(Array)
        warn "#{self}::check_parameter: options[:types] - '#{types}' - should contain only classes or arrays of classes" if types.is_a?(::Array) && !types.all? { |c| ::Class === c || (::Array === c && c.all? { |c2| ::Class === c2 }) }

        unless types.any? do |t|

          case t
          when ::Class

            # the (presumed) scalar argument is of type t?
            value.is_a?(t)
          when ::Array

            # the (presumed) vector argument's elements are the
            # possible types
            value.all? { |v| t.any? { |t2| v.is_a?(t2) }} if ::Array === value
          else

          end
        end then

          failed_check = true

          unless options[:nothrow]

            unless message

              s_name = name.is_a?(String) ? "'#{name}' " : ''

              types_0 = types.select { |t| ::Class === t }.uniq
              types_ar = types.select { |t| ::Array === t }.flatten.uniq

              if types_ar.empty?

                s_types_0 = Util_.join_with_or types_0

                message = "#{param_s} #{s_name}(#{value.class}) must be an instance of #{s_types_0}"
              elsif types_0.empty?

                s_types_ar = Util_.join_with_or types_ar

                message = "#{param_s} #{s_name}(#{value.class}) must be an array containing instance(s) of #{s_types_ar}"
              else

                s_types_0 = Util_.join_with_or types_0

                s_types_ar = Util_.join_with_or types_ar

                message = "#{param_s} #{s_name}(#{value.class}) must be an instance of #{s_types_0}, or an array containing instance(s) of #{s_types_ar}"
              end
            end

            raise TypeError, message
          end
        end


        # messages

        messages = options[:responds_to] || []
        messages = [ messages ] unless messages.respond_to? :each

        warn "#{self}::check_parameter: options[:responds_to] of type #{messages.class} - should be #{::Array}" unless messages.is_a?(Array)
        warn "#{self}::check_parameter: options[:responds_to] should contain only symbols or strings" if messages.is_a?(::Array) && !messages.all? { |m| ::Symbol === m || ::String === m }

        messages.each do |m|

          unless value.respond_to? m

            s_name = name.is_a?(String) ? "'#{name}' " : ''

            raise TypeError, "#{param_s} #{s_name}(#{value.class}) must respond to the '#{m}' message"
          end
        end

      end

      # reject/require empty?

      unless value.nil?

        if options[:reject_empty]

          warn "#{self}::check_parameter: value '#{value}' of type #{value.class} does not respond to empty?" unless value.respond_to? :empty?

          if value.empty?

            failed_check = true

            unless options[:nothrow]

              unless message
                s_name = name.is_a?(String) ? "'#{name}' " : ''

                message = "#{param_s} #{s_name}must not be empty"
              end

              raise ArgumentError, message
            end
          end
        end

        if options[:require_empty]

          warn "#{self}::check_parameter: value '#{value}' of type #{value.class} does not respond to empty?" unless value.respond_to? :empty?

          unless value.empty?

            failed_check = true

            unless options[:nothrow]

              unless message

                s_name = name.is_a?(String) ? "'#{name}' " : ''

                message = "#{param_s} #{s_name}must be empty"
              end

              raise ArgumentError, message
            end
          end
        end
      end

      # run block

      if value and block

        warn "#{self}::check_parameter: block arity must be 1 or 2" unless (1..2).include? block.arity

        r = nil

        begin

          if 1 == block.arity

            r = block.call(value)
          else

            r = block.call(value, options)
          end

        rescue StandardError => x

          xmsg = x.message || ''

          if xmsg.empty?

            xmsg ||= message

            if xmsg.empty?

              s_name = name.is_a?(String) ? "'#{name}' " : ''
              xmsg = "#{param_s} #{s_name}failed validation against caller-supplied block"
            end

            raise $!, xmsg, $!.backtrace
          end

          raise
        end

        if r.is_a?(::Exception)

          # An exception returned from the block, so raise it, with
          # its message or a custom message

          x = r
          xmsg = x.message || ''

          if xmsg.empty?

            xmsg ||= message

            if xmsg.empty?

              s_name = name.is_a?(String) ? "'#{name}' " : ''
              xmsg = "#{param_s} #{s_name}failed validation against caller-supplied block"
            end

            raise x, xmsg
          end

          raise x

        elsif !r

          failed_check = true

          unless options[:nothrow]

            s_name = name.is_a?(String) ? "'#{name}' " : ''
            xmsg = "#{param_s} #{s_name}failed validation against caller-supplied block"

            if value.is_a?(::Numeric)

              raise RangeError, xmsg
            else

              raise ArgumentError, xmsg
            end
          end

        elsif r.is_a?(::TrueClass)

          ;
        else

          value = r
        end
      end

      # check value(s)

      unless value.nil? || !(values = options[:values])

        warn "#{self}::check_parameter: options[:values] of type #{values.class} - should be #{::Array}" unless values.is_a?(Array)

        found = false

        io = options[:ignore_order] && ::Array === value

        do_case = options[:ignore_case] ? lambda do |v|

          case v
          when ::String

            :string
          when ::Array

            :array_of_strings if v.all? { |s| ::String === s }
          else

            nil
          end
        end : lambda { |v| nil }

        value_ic = do_case.call(value)
        value_io = nil
        value_uc = nil

        values.each do |v|

          if ::Range === v && !(::Range === value) && v.cover?(value)

            found = true
            break
          end

          if value == v

            found = true
            break
          end

          # ignore-case comparing

          if value_ic

            unless value_uc

              case value_ic
              when :string

                value_uc = value.upcase
              when :array_of_strings

                value_uc = value.map(&:upcase)
                value_uc = value_uc.sort if io
              end
            end

            v_ic = do_case.call(v)

            if v_ic == value_ic

              case v_ic
              when :string

                if value_uc == v.upcase

                  found = true
                  break
                end
              when :array_of_strings

                v_uc = v.map(&:upcase)
                v_uc = v_uc.sort if io

                if value_uc == v_uc

                  found = true
                  break
                end
              end
            end
          elsif io

            unless value_io

              value_io = value.sort
            end

            if ::Array === v

              v_io = v.sort

              if value_io == v_io

                found = true
                break
              end
            end
          end
        end

        unless found

          failed_check = true

          unless options[:nothrow]

            unless message

              s_name = name.is_a?(String) ? "'#{name}' " : ''

              message = "#{param_s} #{s_name}value '#{value}' not found equal/within any of required values or ranges"
            end

            if value.is_a?(::Numeric)

              raise RangeError, message
            else

              raise ArgumentError, message
            end
          end
        end
      end

      failed_check ? nil : value
    end
  end # module ParameterChecking
end # module Quality
end # module Xqsr3

# ############################## end of file ############################# #

