# frozen_string_literal: true

source "https://rubygems.org"

# no-op on Bundler that lacks the lockfile DSL (Ruby 2.x CI)
lockfile false if respond_to?(:lockfile)

gemspec

# rake 13 requires Ruby >= 2.3
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.3")

  gem "rake", '~> 13.0'
else

  gem "rake", '~> 12.3'
end

gem "test-unit", '~> 3.0'
