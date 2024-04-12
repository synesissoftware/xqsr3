
require 'xqsr3/hash_utilities/key_matching'

class Hash

  # Extended method implemented by Xqsr3::HashUtilities::KeyMatching
  #
  # === Signature
  #
  # * *Parameters:*
  #   - +re+ (Regexp) The regular expression
  #   - +options+ (Hash) See Xqsr3::HashUtilities::KeyMatching
  def match re, **options

    return ::Xqsr3::HashUtilities::KeyMatching.match self, re, **options
  end
end

