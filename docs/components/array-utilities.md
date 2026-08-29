# xqsr3 Array Utilities <!-- omit in toc -->

Array utilities provide standalone operations for working with Ruby arrays.
The current component is a formatter for presenting alternatives in
human-readable text.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [When to use it](#when-to-use-it)
- [JoinWithOr](#joinwithor)
- [Formatting options](#formatting-options)
- [Standalone and extension forms](#standalone-and-extension-forms)


## Loading

```Ruby
require 'xqsr3/array_utilities'
```

Or load the component directly:

```Ruby
require 'xqsr3/array_utilities/join_with_or'
```

The standalone module is
`Xqsr3::ArrayUtilities::JoinWithOr`.


## When to use it

Use `join_with_or` for messages that describe alternatives, such as accepted
formats, permitted values, or choices presented to a user. It is not a
general-purpose serialization method: it adds grammatical spacing and an
optional Oxford comma.


## `JoinWithOr`

`Xqsr3::ArrayUtilities::JoinWithOr.join_with_or` formats values using these
cardinality rules:

* `nil` and an empty array produce `''`;
* one value produces that value;
* two values are joined with `or` and no comma;
* three or more values use commas and, by default, an Oxford comma before
  `or`.

```Ruby
require 'xqsr3/array_utilities/join_with_or'

formatter = Xqsr3::ArrayUtilities::JoinWithOr

formatter.join_with_or([])
# => ''
formatter.join_with_or(['red'])
# => 'red'
formatter.join_with_or(['red', 'green'])
# => 'red or green'
formatter.join_with_or(['red', 'green', 'blue'])
# => 'red, green, or blue'
```

Values are interpolated into the result, so they do not need to be strings.
The array argument itself must be an `Array` or `nil`; another type raises
`TypeError`.


## Formatting options

The `or` word, separator, Oxford-comma policy, and quote character are
independent options:

```Ruby
formatter.join_with_or(
  ['red', 'green', 'blue'],
  or: 'OR',
  separator: ';',
  oxford_comma: false,
  quote_char: '"',
)
# => '"red"; "green" OR "blue"'
```

The options are:

* `or` replaces the default word `or`;
* `separator` replaces the default comma between items;
* `oxford_comma: false` removes the separator before `or` for lists of three
  or more values;
* `quote_char` surrounds every value with the supplied character.

The Oxford-comma option has no effect for zero, one, or two values. A
`quote_char` is applied literally to both sides and does not escape quote
characters already present in a value.


## Standalone and extension forms

The extension form adds `Array#join_with_or`:

```Ruby
require 'xqsr3/extensions/array/join_with_or'

['red', 'green', 'blue'].join_with_or
# => 'red, green, or blue'
```

The extension delegates to the standalone implementation. Use the standalone
form in reusable libraries that want to avoid modifying `Array`; use the
extension form when method syntax improves the surrounding application code.

For executable behavioural examples, see
`test/unit/array_utilities/tc_join_with_or.rb`.


<!-- ########################### end of file ########################### -->
