# xqsr3 IO <!-- omit in toc -->

The IO component writes strings, arrays, and hashes to either a named file or
an existing writable stream. It handles line separators, hash column
separators, and the common case where input already contains line endings.

The API is a class-level writer: use `Xqsr3::IO.writelines` for the
standalone form or `IO.writelines` after loading the extension.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [When to use it](#when-to-use-it)
- [Basic writing](#basic-writing)
- [Input forms](#input-forms)
- [Formatting options](#formatting-options)
- [Line-ending deduction](#line-ending-deduction)
- [Targets and return value](#targets-and-return-value)
- [Standalone and extension forms](#standalone-and-extension-forms)


## Loading

Load the standalone component:

```Ruby
require 'xqsr3/io/writelines'
```

Or load the IO extension:

```Ruby
require 'xqsr3/extensions/io/writelines'
```


## When to use it

Use `writelines` when the data is already structured as records and the
output needs consistent separators. It is more expressive than manually
looping when the records are arrays, hashes, or strings with known line
handling.

Use a lower-level stream API when output requires per-record state, complex
escaping, buffering control, or a format-specific serializer.


## Basic writing

Write to a path:

```Ruby
require 'xqsr3/io/writelines'

Xqsr3::IO.writelines('output.txt', ['first', 'second'])
# creates:
# first
# second
```

Write to an existing stream when the caller owns its lifetime:

```Ruby
require 'xqsr3/io/writelines'
require 'stringio'

output = StringIO.new
Xqsr3::IO.writelines(output, ['first', 'second'])
output.string # => "first\nsecond\n"
```

When the target is a path, the file is opened in write mode and therefore
replaced. When the target is a stream, the stream remains open and receives
the output through its `<<` method.


## Input forms

An array writes one converted element per line:

```Ruby
require 'stringio'

output = StringIO.new
Xqsr3::IO.writelines(output, [1, :two, false])
output.string # => "1\ntwo\nfalse\n"
```

Each element is converted with `to_s`; no additional leading space is added.

A hash writes each key/value pair on one line. The default column separator
is the empty string:

```Ruby
output = StringIO.new
Xqsr3::IO.writelines(output, { 'host' => 'localhost', 'port' => 8080 })
output.string # => "hostlocalhost\nport8080\n"
```

A string without a newline is treated as one entry. A string containing
newlines is split into entries while preserving a final empty entry, so
existing line endings can be handled without automatically adding another
separator.


## Formatting options

The options hash supports:

* `line_separator`, which is appended after each output entry;
* `column_separator`, which is inserted between each hash key and value;
* `no_last_eol`, which suppresses the line separator after the final entry;
* `eol_lookahead_limit`, which controls how many entries are inspected when
  deducing whether input already contains line endings.

```Ruby
output = StringIO.new
Xqsr3::IO.writelines(
  output,
  { 'host' => 'localhost', 'port' => 8080 },
  line_separator: "\r\n",
  column_separator: '=',
  no_last_eol: true,
)
output.string # => "host=localhost\r\nport=8080"
```

The return value is the number of input entries written, not the number of
bytes or characters. For a hash, this is the number of key/value pairs.


## Line-ending deduction

When `line_separator` is omitted, the implementation examines input entries
and defaults to `"\n"`. If an examined key or value already contains `"\n"`,
it uses an empty separator so that an additional line ending is not inserted.

The default lookahead limit is 20 entries. Set it to `nil` to inspect every
entry, or to `0` to skip inspection and use `"\n"`:

```Ruby
output = StringIO.new
Xqsr3::IO.writelines(
  output,
  ["first\n", "second\n"],
  line_separator: '|',
)
output.string # => "first\n|second\n|"
```

An explicit `line_separator` always wins over deduction. This is useful when
input records deliberately contain their own line endings but a boundary
separator is still required.


## Targets and return value

The target must be a path string or respond to `<<`. Contents must be a
string, hash, or array. Invalid targets and contents fail through parameter
validation before writing begins.

Use `StringIO` or another writable stream when output should be captured in
memory. Passing a string target always means a filesystem path; a string
cannot act as an in-memory output buffer.


## Standalone and extension forms

The extension adds `IO.writelines` while retaining the same underlying
implementation:

```Ruby
require 'xqsr3/extensions/io/writelines'

IO.writelines('output.txt', ['first', 'second'])
```

The standalone form avoids modifying the `IO` class and is preferable for a
reusable library that wants explicit dependencies. The extension form is
convenient for application code that already uses xqsr3's standard-library
extensions.

For executable behavioural examples, see
`test/unit/io/tc_writelines.rb`.


<!-- ########################### end of file ########################### -->
