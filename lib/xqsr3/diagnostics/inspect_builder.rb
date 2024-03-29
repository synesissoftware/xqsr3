
# ######################################################################## #
# File:     lib/xqsr3/diagnostics/inspect_builder.rb
#
# Purpose:  ::Xqsr3::Diagnostics::InspectBuilder module
#
# Created:  4th September 2018
# Updated:  29th March 2024
#
# Home:     http://github.com/synesissoftware/xqsr3
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2018-2019, Matthew Wilson and Synesis Software
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


require 'xqsr3/string_utilities/truncate'

=begin
=end

module Xqsr3
module Diagnostics

module InspectBuilder

  # @!visibility private
  module InspectBuilder_Utilities # :nodoc: all

    # @!visibility private
    NORMALISE_FUNCTION = lambda { |ar| ar.map { |v| v.to_s }.map { |v| '@' == v[0] ? v : "@#{v}" } }
  end # module InspectBuilder_Utilities

  # Generates an inspect string for the +include+-ing class
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +o+ The target of the +inspect+ message for which a message will be built
  #
  # * *Options:*
  #   - +:no_class+ (boolean) Elides the class qualification
  #   - +:no_object_id+ (boolean) Elides the object id
  #   - +:show_fields+ (boolean) Shows (all) object fields
  #   - +:hidden_fields+ ([ String ]) Names of fields to be omitted (when +:show_fields+ is specified). Overridden by +:shown_fields+
  #   - +:shown_fields+ ([ String ]) Names of fields to be shown (when +:show_fields+ is specified). Overrides +:hidden_fields+
  #   - +:truncate_width+ (Integer) Specifies a maximum width for the values of fields
  #   - +:deep_inspect+ (boolean) Causes fields' values to be obtained via their own +inspect+ methods
  def self.make_inspect o, **options

    r = ''

    unless options[:no_class]

      r += o.class.to_s
    end

    unless options[:no_object_id]

      r += ':' unless r.empty?
      r += "0x#{o.object_id.to_s.rjust(16, '0')}"
    end

    if options[:show_fields]

      normalise = InspectBuilder_Utilities::NORMALISE_FUNCTION

      hide_fields = normalise.call(options[:hidden_fields] || [])
      show_fields = normalise.call(options[:shown_fields] || [])
      trunc_w = options[:truncate_width]
      ivars = normalise.call(o.instance_variables)

      unless show_fields.empty?

        ivars = ivars & show_fields
      else

        o.class.ancestors.each do |ancestor|

          ihf_constant = :INSPECT_HIDDEN_FIELDS

          if ancestor.const_defined? ihf_constant

            ihfs = ancestor.const_get ihf_constant

            if ::Array === ihfs && ihfs.all? { |c| ::String === c }

              hide_fields += normalise.call(ihfs)
            else

              warn "class/module #{ancestor}'s #{ihf_constant} should be an array of strings"
            end
          end
        end

        ivars = ivars - hide_fields
      end

      els = ivars.sort.map do |iv_name|

        iv_value = o.instance_variable_get(iv_name)
        iv_class = iv_value.class
        iv_value = ::Xqsr3::StringUtilities::Truncate.string_truncate(iv_value.to_s, trunc_w) if trunc_w
        if options[:deep_inspect]

          iv_value = iv_value.inspect
        else

          case iv_value
          when ::Array


          when ::String

            iv_value = "'#{iv_value}'"
          end
        end

        "#{iv_name}(#{iv_class})=#{iv_value}"
      end.join('; ')

      r += ': ' unless r.empty?
      r += els
    end

    r = '#<' + r + '>'

    r
  end

  # Creates an inspect string from self
  #
  # see InspectBuilder::make_inspect
  def make_inspect **options

    ::Xqsr3::Diagnostics::InspectBuilder.make_inspect self, **options
  end

end # module InspectBuilder

end # module Diagnostics
end # module Xqsr3

# ############################## end of file ############################# #

