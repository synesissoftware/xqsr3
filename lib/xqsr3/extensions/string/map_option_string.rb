# frozen_string_literal: true

require 'xqsr3/command_line_utilities/map_option_string'


class String

  include ::Xqsr3::CommandLineUtilities::MapOptionString
end # class String

# Standard NilClass extension for safely mapping an absent option string.
class NilClass

  # Returns nil because a nil option string cannot match a declared option.
  def map_option_string *args

    nil
  end
end

