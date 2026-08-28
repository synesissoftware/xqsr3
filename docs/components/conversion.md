# xqsr3 Conversion <!-- omit in toc -->

Conversion components turn external scalar values into application values
while making invalid-input policy explicit. Use them at boundaries such as
configuration files, command-line options, and environment variables.

The two parsers have deliberately different failure models: boolean parsing
returns a default when there is no match, while integer parsing preserves
Ruby's normal conversion exceptions unless a fallback is requested.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a parser](#choosing-a-parser)
- [BoolParser](#boolparser)
- [IntegerParser](#integerparser)
- [Conversion versus validation](#conversion-versus-validation)


## Loading

Load both parsers through the category entry point:

```Ruby
require 'xqsr3/conversion'
```

Or load only the parser required by the application:

```Ruby
require 'xqsr3/conversion/bool_parser'
require 'xqsr3/conversion/integer_parser'
```

The parsers are defined in `Xqsr3::Conversion`.


## Choosing a parser

* Choose `BoolParser` for configurable textual true/false tokens;
* Choose `IntegerParser` when Ruby's `Integer` conversion rules, including
  numeric bases, are appropriate;
* Use a fallback option when invalid external input is expected and should not
  interrupt processing;
* Leave fallbacks out when invalid input should be surfaced to the caller.


## `BoolParser`

`Xqsr3::Conversion::BoolParser.to_bool` performs a whole-string match. By
default, `true`, `TRUE`, and `1` produce `true`; `false`, `FALSE`, and `0`
produce `false`; anything else produces `nil`.

```Ruby
require 'xqsr3/conversion/bool_parser'

parser = Xqsr3::Conversion::BoolParser

parser.to_bool('true')  # => true
parser.to_bool('0')     # => false
parser.to_bool('truest') # => nil
```

The parser accepts custom literal strings and regular expressions:

```Ruby
parser.to_bool(
  'enabled',
  true_values: ['enabled', 'yes'],
  false_values: ['disabled', 'no'],
) # => true

parser.to_bool(
  'enabled for production',
  true_values: /\Aenabled/,
) # => true
```

Regular expressions are applied as supplied. The defaults are anchored and
case-insensitive, which is why substrings such as `truest` and `falsehood`
are not accepted by default.

Fallback and result values are independently configurable. The long option
names and their shorter aliases are equivalent:

* `default_value` / `default` is returned when neither set matches;
* `true_value` / `true` is returned when a true token matches;
* `false_value` / `false` is returned when a false token matches.

The configured values may be any objects, including `nil` and `false`.
True-token matching is attempted before false-token matching, so overlapping
custom matchers resolve to the true result.


## `IntegerParser`

`Xqsr3::Conversion::IntegerParser.to_integer` wraps Ruby integer conversion
with optional fallback behaviour. It also has an instance form when the module
is included.

```Ruby
require 'xqsr3/conversion/integer_parser'

parser = Xqsr3::Conversion::IntegerParser

parser.to_integer('42')       # => 42
parser.to_integer('-100', 2)  # => -4
parser.to_integer(42, 16)     # => 42
```

The `base` argument is passed to Ruby's conversion only for string inputs.
Non-string inputs use the ordinary one-argument conversion, so a base does
not reinterpret an existing numeric value.

By default, `nil` and malformed values raise the underlying conversion
exception:

```Ruby
parser.to_integer('not a number') # raises ArgumentError
parser.to_integer(nil)            # raises TypeError
```

Use `default` to return a chosen value for `nil` or conversion failure:

```Ruby
parser.to_integer('not a number', default: 0)       # => 0
parser.to_integer(nil, default: :missing)           # => :missing
```

Use `nil: true` when all failed conversions should return `nil`. If both
options are supplied, `default` takes precedence:

```Ruby
parser.to_integer('not a number', nil: true)                  # => nil
parser.to_integer('not a number', default: :missing, nil: true) # => :missing
```

For custom recovery, pass a block. It receives the conversion exception, the
original argument, the base, and the options hash. Its return value becomes
the result:

```Ruby
parser.to_integer('not a number') do |exception, argument, base, options|
  warn "#{argument.inspect}: #{exception.message}"
  :unparseable
end # => :unparseable
```

The recovery block is invoked for `ArgumentError` and `TypeError`. Exceptions
raised by the recovery block itself are not swallowed.


## Conversion versus validation

These parsers are conversion tools, not complete input-validation policies.
For example, `BoolParser` can return an application-specific sentinel, and
`IntegerParser` can delegate failure handling to a block. If an application
must reject unknown values, check for the chosen sentinel or allow the
conversion exception to propagate rather than silently accepting a fallback.

For executable behavioural examples, see the unit tests in
`test/unit/conversion/`.


<!-- ########################### end of file ########################### -->
