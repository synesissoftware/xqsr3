# xqsr3 Quality <!-- omit in toc -->

The Quality components provide reusable parameter and option checks for
public method boundaries. They centralise common failure messages while
allowing a caller to choose whether invalid input raises or returns a
failure value.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [A boundary-checking pattern](#a-boundary-checking-pattern)
- [ParameterChecking](#parameterchecking)
- [Type and shape checks](#type-and-shape-checks)
- [Value and emptiness checks](#value-and-emptiness-checks)
- [Custom validation](#custom-validation)
- [Option checking](#option-checking)
- [Failure policy](#failure-policy)
- [Compatibility](#compatibility)


## Loading

Load the quality category:

```Ruby
require 'xqsr3/quality'
```

Or load the component directly:

```Ruby
require 'xqsr3/quality/parameter_checking'
```

The module is defined as `Xqsr3::Quality::ParameterChecking`.


## A boundary-checking pattern

Include the module in a class when checks are part of the class's
implementation:

```Ruby
require 'xqsr3/quality/parameter_checking'

class Endpoint
  include Xqsr3::Quality::ParameterChecking

  def initialize(host, port)
    @host = check_parameter(
      host,
      'host',
      type: String,
      reject_empty: true,
    )
    @port = check_parameter(port, 'port', values: [1..65_535])
  end
end
```

The module also exposes class-level forms for utility code:

```Ruby
checker = Xqsr3::Quality::ParameterChecking
checker.check_parameter('localhost', 'host', type: String)
# => 'localhost'
```

Checks return the accepted or transformed value. This makes them convenient
in assignments and constructor boundaries.


## `ParameterChecking`

`check_parameter(value, name, options = {})` checks one value. The `name` is
used in generated error messages and may be a string or symbol. The main
options are:

* `type` accepts one class;
* `types` accepts several classes, including `:boolean` for either Boolean
  class;
* an array within `types` requires an array whose elements match one of the
  nested classes;
* `responds_to` requires one or more methods;
* `allow_nil` or its alias `nil` permits `nil`;
* `strip_str_whitespace` strips a `to_str` value before subsequent checks.

For example:

```Ruby
checker.check_parameter(true, 'enabled', types: [:boolean])
# => true
checker.check_parameter(%w[red blue], 'colours', types: [[String]])
# => ['red', 'blue']
checker.check_parameter({}, 'options', responds_to: [:[], :keys])
# => {}
```

Type failures raise `TypeError` by default. A nil value that is not allowed
raises `ArgumentError`.


## Type and shape checks

Use `type` for one expected class and `types` for alternatives:

```Ruby
checker.check_parameter(12, 'count', type: Integer)
# => 12

checker.check_parameter(:ready, 'state', types: [String, Symbol])
# => :ready
```

Nested type arrays describe the contents of an array rather than accepting
the array class itself:

```Ruby
checker.check_parameter([1, 2, 3], 'ids', types: [[Integer]])
# => [1, 2, 3]
```

`responds_to` checks capabilities rather than concrete classes. It can accept
a single method name or an array:

```Ruby
checker.check_parameter({}, 'options', responds_to: :keys)
# => {}
```


## Value and emptiness checks

`values` accepts an array of permitted values. Range entries are treated as
inclusive membership checks:

```Ruby
checker.check_parameter(8080, 'port', values: [1..65_535])
# => 8080
```

For strings, `ignore_case: true` enables case-insensitive comparison. For
arrays, `ignore_order: true` permits the same values in a different order;
the two options can be combined for arrays of strings:

```Ruby
checker.check_parameter(
  'JSON',
  'format',
  values: ['json', 'yaml'],
  ignore_case: true,
)
# => 'JSON'

checker.check_parameter(
  %w[blue red],
  'colours',
  values: [%w[red blue]],
  ignore_order: true,
)
# => ['blue', 'red']
```

Use `reject_empty: true` to require a non-empty value, or
`require_empty: true` to require an empty value. These checks apply to values
responding to `empty?`. `strip_str_whitespace: true` runs first, so a string
containing only whitespace can become empty before `reject_empty` is checked.


## Custom validation

Pass a one-argument block for a value-only predicate or a two-argument block
to receive the value and options. A truthy Boolean result accepts the value;
any other non-`true` result replaces the value; a falsey result rejects it:

```Ruby
checker.check_parameter(7, 'count') { |value| value.positive? }
# => 7
```

For numeric values, a failed predicate raises `RangeError`; for other values
it raises `ArgumentError`. A block may return an exception instance to raise
that exception, or raise its own exception directly.

The block is not called for `nil` values, and must have arity one or two.


## Option checking

`check_option(options_hash, name, options = {})` applies the same validation
rules to a named option. It is useful when a method accepts a keyword/options
hash:

```Ruby
options = { port: 8080 }

checker.check_option(
  options,
  :port,
  type: Integer,
  values: [1..65_535],
)
# => 8080
```

The name can be an array of aliases. The first present alias is selected, and
the selected value is returned:

```Ruby
checker.check_option(
  { stringize: :name },
  [:stringise, :stringize],
)
# => :name
```

With `allow_nil: true` or `nil: true`, a missing aliased option returns
`nil` instead of raising. Otherwise a missing option is reported as an option
failure.


## Failure policy

By default, failed checks raise:

* `ArgumentError` for missing, nil, empty, or invalid non-numeric values;
* `TypeError` for type, capability, or option-shape failures;
* `RangeError` for numeric values outside permitted ranges or failing a
  custom numeric predicate.

Use `nothrow: true` when a caller needs a pass/fail probe. A failed check then
returns `nil` instead of raising, while a successful check still returns its
value. Use `message` to replace the generated exception message.

`check_param` is an obsolete alias for `check_parameter`; new code should use
the longer name.


## Compatibility

`ParameterChecking` is includable, adds class-level forwarding methods when
included, and keeps the internal instance checking methods private. This
makes it suitable for implementation reuse without expanding the public
instance API of a class.

For executable behavioural examples, see
`test/unit/quality/tc_parameter_checking.rb`.


<!-- ########################### end of file ########################### -->
