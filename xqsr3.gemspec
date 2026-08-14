# ######################################################################## #
# File:     xqsr3.gemspec
#
# Purpose:  Gemspec for xqsr3 library
#
# Created:  14th February 2014
# Updated:  14th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'xqsr3/version'


Gem::Specification.new do |spec|

  spec.name         = 'xqsr3'
  spec.summary      = 'xqsr3'
  spec.version      = Xqsr3::VERSION
  spec.description  = <<END_DESC
eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries is a
lightweight, low-coupling library of assorted extensions to standard Ruby
and 3rd-party libraries.
END_DESC
  spec.authors      = [ 'Matt Wilson' ]
  spec.email        = 'matthew@synesis.com.au'
  spec.homepage     = 'https://github.com/synesissoftware/xqsr3'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 2.0' ]

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/xqsr3/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/xqsr3/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/xqsr3',
    'source_code_uri' => 'https://github.com/synesissoftware/xqsr3',
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'EXAMPLES*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
end


# ############################## end of file ############################# #
