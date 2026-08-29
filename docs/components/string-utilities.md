# xqsr3 String Utilities <!-- omit in toc -->

String utilities provide small operations for matching, normalising,
quoting, converting, and shortening strings. They are especially useful when
turning loosely formatted external text into a stable value for later
processing.

Several methods have deliberately useful return values rather than merely
returning `true` or `false`: the prefix and suffix methods return the matching
text, while the `nil_if_*` methods return either the original string or
`nil`.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a utility](#choosing-a-utility)
- [Prefix and suffix matching](#prefix-and-suffix-matching)
- [Blank-value normalization](#blank-value-normalization)
- [Conditional quoting](#conditional-quoting)
- [Symbol conversion](#symbol-conversion)
- [Truncation](#truncation)
- [Extensions and standalone forms](#extensions-and-standalone-forms)


## Loading

Load all standalone string utilities through the category entry point:

```Ruby
require 'xqsr3/string_utilities'
```

Or load a specific utility:

```Ruby
require 'xqsr3/string_utilities/to_symbol'
```

The utility modules are defined in `Xqsr3::StringUtilities`.


## Choosing a utility

* Use `starts_with?` or `ends_with?` when the matching text itself is useful;
* Use `nil_if_empty` when whitespace is meaningful and only `''` is blank;
* Use `nil_if_whitespace` when input containing only whitespace is also blank;
* Use `quote_if` for display or command-line-like formatting;
* Use `to_symbol` when accepting a restricted identifier-like external value;
* Use `truncate` when output must fit a known character width.


## Prefix and suffix matching

`starts_with?` and `ends_with?` accept one or more strings. They return the
matching prefix or suffix string, or `nil` when no argument matches. This
allows a match to be used directly:

```Ruby
require 'xqsr3/string_utilities/starts_with'
require 'xqsr3/string_utilities/ends_with'

name = 'xqsr3-utilities.rb'

Xqsr3::StringUtilities::StartsWith.string_starts_with?(name, 'xqsr3')
# => 'xqsr3'
Xqsr3::StringUtilities::EndsWith.string_ends_with?(name, '.rb')
# => '.rb'
Xqsr3::StringUtilities::StartsWith.string_starts_with?(name, 'ruby', 'xqsr3')
# => 'xqsr3'
```

The standalone forms are `StringUtilities::StartsWith.string_starts_with?`
and `StringUtilities::EndsWith.string_ends_with?`. A prefix or suffix may be
`nil`, or an object responding to `to_str`; other types raise `TypeError`.
Passing no arguments, or a `nil` argument, returns the empty string rather
than `nil`.

Matching is literal and case-sensitive. These methods do not interpret
regular expressions.


## Blank-value normalization

`nil_if_empty` returns `nil` for `''` and returns the original string for
every non-empty string, including whitespace:

```Ruby
Xqsr3::StringUtilities::NilIfEmpty.string_nil_if_empty(' ') # => ' '
Xqsr3::StringUtilities::NilIfEmpty.string_nil_if_empty('')  # => nil
```

`nil_if_whitespace` uses `String#strip`: it returns `nil` for an empty or
whitespace-only string, and otherwise returns the original, unmodified string:

```Ruby
Xqsr3::StringUtilities::NilIfWhitespace.string_nil_if_whitespace('  ')
# => nil
Xqsr3::StringUtilities::NilIfWhitespace.string_nil_if_whitespace('  ruby ')
# => '  ruby '
```

Neither method strips a non-blank value. Use `strip` explicitly when
normalisation of the surviving value is also required.


## Conditional quoting

`quote_if` converts its input to a string and surrounds it with quotes only
when it contains a quotable character. By default, whitespace is quotable and
the surrounding quote is `"`.

```Ruby
require 'xqsr3/string_utilities/quote_if'

Xqsr3::StringUtilities::QuoteIf.quote_if('ruby')
# => 'ruby'
Xqsr3::StringUtilities::QuoteIf.quote_if('ruby language')
# => '"ruby language"'
```

Use `quotables` to select the trigger. It accepts a string, an array of
strings, or a regular expression. Use `quotes` to provide either one string
for both sides or an array containing opening and closing strings:

```Ruby
Xqsr3::StringUtilities::QuoteIf.quote_if(
  'a=b',
  quotables: '=',
  quotes: ['<', '>'],
)
# => '<a=b>'

Xqsr3::StringUtilities::QuoteIf.quote_if('a/b', quotables: ['/'])
# => '"a/b"'
```

An invalid `quotables` type raises `ArgumentError`. Existing quoted strings
are not specially detected; quoting is based only on whether the configured
quotables are present.


## Symbol conversion

`to_symbol` accepts a string, or an object responding to `to_str`, and returns
an identifier-like symbol. ASCII letters and underscores are retained, digits
are retained after the first character, and other accepted separators are
converted to underscores:

```Ruby
require 'xqsr3/string_utilities/to_symbol'

Xqsr3::StringUtilities::ToSymbol.string_to_symbol('user-name')
# => :user_name
Xqsr3::StringUtilities::ToSymbol.string_to_symbol('user name')
# => :user_name
Xqsr3::StringUtilities::ToSymbol.string_to_symbol(
  'user-name',
  reject_hyphens: true,
) # => nil
```

By default, hyphens, spaces, and tabs are converted to underscores. Other
characters cause `nil` unless they appear in `transform_characters`, in which
case they are also converted to underscores. `reject_spaces`, `reject_tabs`,
and `reject_whitespace` reject the corresponding separators instead of
transforming them. An empty input returns `nil`.

The standalone form is
`StringUtilities::ToSymbol.string_to_symbol(string, options)`.


## Truncation

`truncate` limits a string to a requested width. If the string already fits,
it is returned unchanged. Otherwise, the default omission string `...` is
included within the requested width:

```Ruby
require 'xqsr3/string_utilities/truncate'

Xqsr3::StringUtilities::Truncate.string_truncate('abcdef', 6)
# => 'abcdef'
Xqsr3::StringUtilities::Truncate.string_truncate('abcdefgh', 6)
# => 'abc...'
Xqsr3::StringUtilities::Truncate.string_truncate('abcdefgh', 2)
# => '..'
```

Provide `omission` to change the marker. If the requested width is shorter
than the omission, the omission itself is truncated:

```Ruby
Xqsr3::StringUtilities::Truncate.string_truncate(
  'abcdefgh',
  6,
  omission: ' [...] ',
)
# => ' [...]'
```

The standalone form is
`StringUtilities::Truncate.string_truncate(string, width, options)`.


## Extensions and standalone forms

Each utility has a standalone module method and a corresponding instance
method when its extension is loaded. The extension methods are grouped under
`xqsr3/extensions/string`; loading all extension groups is broader than
loading the standalone utility category.

For executable behavioural examples, see the string extension tests in
`test/unit/extensions/string/` and the standalone truncation tests in
`test/unit/string_utilities/`.


<!-- ########################### end of file ########################### -->
