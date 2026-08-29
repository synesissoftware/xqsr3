# xqsr3 Getting Started <!-- omit in toc -->

This guide takes a small application from installation to its first useful
**xqsr3** components. It uses explicit loading throughout, so each example
makes its dependency on a component visible.


## Table of Contents <!-- omit in toc -->

- [Install the gem](#install-the-gem)
- [Load only what you need](#load-only-what-you-need)
- [Use a container](#use-a-container)
- [Convert external values](#convert-external-values)
- [Validate a boundary](#validate-a-boundary)
- [Write structured output](#write-structured-output)
- [Choose the next page](#choose-the-next-page)


## Install the gem

Install the released gem:

```Shell
gem install xqsr3
```

For an application managed with Bundler, add the gem to its `Gemfile`:

```Ruby
gem 'xqsr3'
```

Then run:

```Shell
bundle install
```

**xqsr3** has no runtime dependencies outside the Ruby standard library.


## Load only what you need

Components are not all loaded by a single default `require`. Start with a
category entry point when several related components are needed:

```Ruby
require 'xqsr3/containers'
require 'xqsr3/conversion'
```

Use a component-specific path when the application needs only one feature:

```Ruby
require 'xqsr3/containers/frequency_map'
```

The category entry points expose namespaced components without changing Ruby's
core classes. Extension entry points, such as
`xqsr3/extensions/string`, deliberately add methods to standard Ruby classes.
Use those broader extensions only when that global method syntax is intended.


## Use a container

Suppose an application has received a list of words and wants both the total
number of observations and the most frequent words:

```Ruby
require 'xqsr3/containers/frequency_map'

words = %w[ruby ruby crystal ruby crystal]
frequencies = Xqsr3::Containers::FrequencyMap::ByElement[*words]

frequencies.count # => 5, total observations
frequencies.size  # => 2, distinct words

frequencies.each_by_frequency do |word, frequency|
  puts "#{word}: #{frequency}"
end
```

`FrequencyMap` is a good fit because each word has one numeric count. Use
`MultiMap` instead when each key needs an ordered array of associated values.
See the [Containers catalogue page](../components/containers.md) for the
choice and mutation rules.


## Convert external values

External values should be converted at their input boundary, where the
application can choose what invalid input means:

```Ruby
require 'xqsr3/conversion'

enabled = Xqsr3::Conversion::BoolParser.to_bool(
  ENV.fetch('FEATURE_ENABLED', 'false'),
  default_value: false,
)

port = Xqsr3::Conversion::IntegerParser.to_integer(
  ENV.fetch('PORT', '8080'),
  default: 8080,
)
```

The Boolean parser returns its default for an unrecognised token. The integer
parser uses Ruby's conversion rules and returns the specified fallback for
invalid or nil input. Omit the fallback when invalid input should raise.


## Validate a boundary

Use `ParameterChecking` when a value must satisfy both a type and a domain
rule:

```Ruby
require 'xqsr3/quality/parameter_checking'

checker = Xqsr3::Quality::ParameterChecking

port = checker.check_parameter(
  port,
  'port',
  type: Integer,
  values: [1..65_535],
)
```

Successful checks return the accepted value, so they can be assigned directly.
By default, invalid types raise `TypeError`; invalid values and ranges raise
`ArgumentError` or `RangeError` according to the value and check. Use
`nothrow: true` when a probe returning `nil` is more useful than an exception.


## Write structured output

Write an array or hash to a path, or pass an existing stream when the caller
needs to retain control of its lifetime:

```Ruby
require 'xqsr3/io/writelines'

Xqsr3::IO.writelines(
  'frequencies.txt',
  frequencies.to_h,
  column_separator: ': ',
  no_last_eol: true,
)
```

`IO.writelines` returns the number of entries written. A path is opened in
write mode and replaced; a stream is left open. See the [IO catalogue
page](../components/io.md) for line-ending deduction and stream examples.


## Choose the next page

The component catalogue explains individual APIs and their edge cases:

* [Array Utilities](../components/array-utilities.md) for human-readable
  alternatives;
* [Command-line Utilities](../components/command-line-utilities.md) for
  option names and shortcuts;
* [Containers](../components/containers.md) for counts and one-to-many data;
* [Conversion](../components/conversion.md) for scalar parsing;
* [Diagnostics](../components/diagnostics.md) for failure context;
* [Extensions](../components/extensions.md) for standard-library methods;
* [Hash Utilities](../components/hash-utilities.md) for transformation and
  matching;
* [IO](../components/io.md) for structured output;
* [Quality](../components/quality.md) for validation;
* [String Utilities](../components/string-utilities.md) for string handling.

The [component catalogue index](../components/README.md) provides the full
list. Task-specific guides will be added here as common workflows are
documented.


<!-- ########################### end of file ########################### -->
