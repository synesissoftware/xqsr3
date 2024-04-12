
require 'xqsr3/command_line_utilities/map_option_string'


class String

  include ::Xqsr3::CommandLineUtilities::MapOptionString
end # class String

class NilClass

  def map_option_string *args

    nil
  end
end

