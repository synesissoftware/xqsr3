# xqsr3 Formatting and Writing Output <!-- omit in toc -->

This guide shows how to turn application values into readable text and write
that text to a file or stream. It separates presentation choices from output
ownership so the same data can be displayed, tested, or persisted.


## Table of Contents <!-- omit in toc -->

- [Format alternatives](#format-alternatives)
- [Prepare strings](#prepare-strings)
- [Limit display width](#limit-display-width)
- [Write sequences](#write-sequences)
- [Write key-value data](#write-key-value-data)
- [Choose a stream or path](#choose-a-stream-or-path)
- [Compose a report](#compose-a-report)


## Format alternatives

Use `join_with_or` when text describes permitted alternatives:

```Ruby
require 'xqsr3/array_utilities/join_with_or'

formats = ['JSON', 'YAML', 'TOML']
message = Xqsr3::ArrayUtilities::JoinWithOr.join_with_or(formats)
# => 'JSON, YAML, or TOML'
```

Configure the conjunction, separator, Oxford comma, or quote character when
the surrounding presentation requires a different style:

```Ruby
Xqsr3::ArrayUtilities::JoinWithOr.join_with_or(
  formats,
  or: 'OR',
  quote_char: '"',
  oxford_comma: false,
)
# => '"JSON", "YAML" OR "TOML"'
```

This formatter is for human-readable messages, not machine-readable
serialization.


## Prepare strings

Use `quote_if` when values should be quoted only if they contain whitespace:

```Ruby
require 'xqsr3/string_utilities/quote_if'

formatter = Xqsr3::StringUtilities::QuoteIf
formatter.quote_if('simple')        # => 'simple'
formatter.quote_if('two words')     # => '"two words"'
```

The `quotables` option can replace whitespace with another trigger. Use
`quotes` when the opening and closing delimiters differ.

Use `nil_if_whitespace` to identify absent human-entered values, and
`nil_if_empty` when whitespace should remain meaningful. Neither method strips
a non-blank value; call `strip` explicitly when that is wanted.


## Limit display width

Use `truncate` for labels, logs, and fixed-width displays:

```Ruby
require 'xqsr3/string_utilities/truncate'

truncator = Xqsr3::StringUtilities::Truncate
truncator.string_truncate('a very long filename.txt', 16)
# => 'a very long f...'
```

The omission string is included within the requested width:

```Ruby
truncator.string_truncate(
  'a very long filename.txt',
  16,
  omission: ' [...]',
)
# => 'a very lon [...]'
```

Choose an omission marker whose meaning is clear in the target interface.
Truncation is based on the string width used by the implementation and does
not provide escaping or format-specific encoding.


## Write sequences

Use `IO.writelines` for an array whose members should become separate output
lines:

```Ruby
require 'xqsr3/io/writelines'
require 'stringio'

output = StringIO.new
Xqsr3::IO.writelines(output, ['first', 'second'])
output.string # => "first\nsecond\n"
```

The method converts array elements with `to_s`, appends a line separator, and
returns the number of entries written. Pass `line_separator: ''` when the
records already contain all required separators.


## Write key-value data

Pass a hash when each output line consists of a key and value:

```Ruby
output = StringIO.new
Xqsr3::IO.writelines(
  output,
  { 'host' => 'localhost', 'port' => 8080 },
  column_separator: '=',
  line_separator: "\n",
  no_last_eol: true,
)
output.string # => "host=localhost\nport=8080"
```

Hash keys and values are converted with `to_s`. Use a serializer instead when
values require escaping, nesting, or a machine-readable format.


## Choose a stream or path

Use a path when xqsr3 should open and replace the file:

```Ruby
Xqsr3::IO.writelines('report.txt', ['first', 'second'])
```

Use a writable stream when the caller owns the destination:

```Ruby
File.open('report.txt', 'w') do |file|
  Xqsr3::IO.writelines(file, ['first', 'second'])
end
```

The path form opens in write mode. The stream form leaves the stream open.
`StringIO` is useful for unit tests because it makes output directly
assertable without filesystem access.


## Compose a report

Keep formatting and writing separate when output may have several consumers:

```Ruby
require 'xqsr3/array_utilities/join_with_or'
require 'xqsr3/io/writelines'

supported = ['JSON', 'YAML', 'TOML']
summary = Xqsr3::ArrayUtilities::JoinWithOr.join_with_or(supported)

Xqsr3::IO.writelines(
  'supported-formats.txt',
  { 'formats' => summary },
  column_separator: ': ',
)
```

This keeps the choice of human-readable wording independent from the choice
of destination. For parsing and validation before formatting, see
[Parsing and Validating External Input](./parsing-and-validating-input.md).
For component-level details, see [Array Utilities](../components/array-utilities.md),
[IO](../components/io.md), and
[String Utilities](../components/string-utilities.md).


<!-- ########################### end of file ########################### -->
