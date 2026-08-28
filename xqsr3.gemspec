# ######################################################################## #
# File:     xqsr3.gemspec
#
# Purpose:  Gemspec for xqsr3 library
#
# Created:  14th February 2014
# Updated:  28th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'xqsr3/version'

PROJECT_URL = 'https://github.com/synesissoftware/xqsr3'


Gem::Specification.new do |spec|

  spec.name         = 'xqsr3'
  spec.summary      = 'eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries'
  spec.version      = Xqsr3::VERSION
  spec.description  = <<END_DESC
eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries is a
lightweight, low-coupling library of assorted extensions to standard Ruby
and 3rd-party libraries.
END_DESC

  spec.authors      = [
    'Matt Wilson',
  ]
  spec.email        = [
    'matthew@synesis.com.au',
  ]
  spec.homepage     = PROJECT_URL
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 2.0', '< 5' ]

  spec.metadata = {
    'bug_tracker_uri' => "#{PROJECT_URL}/issues",
    'changelog_uri' => "#{PROJECT_URL}/blob/master/CHANGES.md",
    'homepage_uri' => PROJECT_URL,
    'source_code_uri' => PROJECT_URL,
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'CONTRIBUTING*',
    'EXAMPLES*',
    'FAQ*',
    'INSTALL*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'SECURITY*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
  spec.files -= [
    '.ruby-version',
    'Gemfile.lock',
  ]
end


# ############################## end of file ############################# #
