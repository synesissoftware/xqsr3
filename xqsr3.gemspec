# gemspec for xqsr3

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'xqsr3/version'

require 'date'

Gem::Specification.new do |spec|

	spec.name			=	'xqsr3'
	spec.version		=	Xqsr3::VERSION
	spec.date			=	Date.today.to_s
	spec.summary		=	'xqsr3'
	spec.description	=	<<END_DESC
eXtensions by fine Quantum for Standard Ruby and 3rd-party libraries is a
lightweight, low-coupling library of assorted extensions to standard ruby and
3rd-party libraries.
END_DESC
	spec.authors		=	[ 'Matt Wilson' ]
	spec.email			=	'matthew@synesis.com.au'
	spec.homepage		=	'http://github.com/synesissoftware/xqsr3'
	spec.license		=	'BSD-3-Clause'

	spec.required_ruby_version = [ '>= 2.0', '< 4' ]

	spec.files			=	Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
end

