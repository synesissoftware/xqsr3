# xqsr3 Parsing and Validating External Input <!-- omit in toc -->

External input often arrives as strings, even when the application needs
Booleans, integers, symbols, or constrained values. This guide shows how to
separate normalization, conversion, and validation so each policy is visible
and testable.


## Table of Contents <!-- omit in toc -->

- [The boundary pipeline](#the-boundary-pipeline)
- [Normalize text](#normalize-text)
- [Convert scalar values](#convert-scalar-values)
- [Validate the result](#validate-the-result)
- [Handle invalid input](#handle-invalid-input)
- [Build a normalized configuration](#build-a-normalized-configuration)
- [Further reading](#further-reading)


## The boundary pipeline

Use this sequence for configuration, environment, and command-line values:

1. Normalize representation-only differences;
2. Convert text into the application's conceptual type;
3. Validate type and domain constraints;
4. Store the accepted value in application state;
5. Report or recover from invalid input according to the caller's policy.

Do not use conversion defaults as a substitute for validation. A default can
hide a misspelled or unsupported input unless that is explicitly the desired
policy.


## Normalize text

Use String Utilities when blank input has a defined meaning:

```Ruby
require 'xqsr3/string_utilities/nil_if_whitespace'

raw_host = ENV['HOST']
host = raw_host && Xqsr3::StringUtilities::NilIfWhitespace
  .string_nil_if_whitespace(raw_host)
```

`nil_if_whitespace` returns `nil` for empty or whitespace-only input and
returns the original non-blank string unchanged. If leading and trailing
whitespace should be removed from an accepted value, do that explicitly:

```Ruby
host = host.strip if host
```

Use `nil_if_empty` instead when whitespace is meaningful:

```Ruby
require 'xqsr3/string_utilities/nil_if_empty'

label = Xqsr3::StringUtilities::NilIfEmpty
  .string_nil_if_empty('  ')
# => '  '
```

This distinction prevents an input-normalization policy from being hidden
inside a later conversion step.


## Convert scalar values

Convert Booleans using explicit accepted tokens:

```Ruby
require 'xqsr3/conversion/bool_parser'

enabled = Xqsr3::Conversion::BoolParser.to_bool(
  ENV.fetch('FEATURE_ENABLED', 'false'),
)
```

The default Boolean vocabulary is `true`, `TRUE`, `1`, `false`, `FALSE`, and
`0`. Unknown text returns `nil`. Configure a fallback when unknown input
should have a deliberate application value:

```Ruby
enabled = Xqsr3::Conversion::BoolParser.to_bool(
  ENV['FEATURE_ENABLED'],
  default_value: false,
)
```

Convert integers with an optional numeric base and failure policy:

```Ruby
require 'xqsr3/conversion/integer_parser'

port = Xqsr3::Conversion::IntegerParser.to_integer(
  ENV.fetch('PORT', '8080'),
)
```

The base applies to string input. Omit `default` and `nil: true` when
malformed input must raise. Use `default` for a specific fallback, or
`nil: true` when all conversion failures should become `nil`.


## Validate the result

Conversion answers “what value does this text represent?” Validation answers
“is that value permitted here?” Keep those questions separate:

```Ruby
require 'xqsr3/quality/parameter_checking'

port = Xqsr3::Quality::ParameterChecking.check_parameter(
  port,
  'port',
  type: Integer,
  values: [1..65_535],
)
```

The check returns the accepted value. A non-integer raises `TypeError`; an
integer outside the permitted range raises `RangeError`.

Validate a finite vocabulary directly:

```Ruby
format = Xqsr3::Quality::ParameterChecking.check_parameter(
  'JSON',
  'format',
  type: String,
  values: ['json', 'yaml'],
  ignore_case: true,
)
# => 'JSON'
```

The accepted value is returned unchanged. If the application wants a
canonical lowercase value, normalize that result explicitly:

```Ruby
format = format.downcase
# => 'json'
```


## Handle invalid input

Choose a failure policy at the boundary rather than deep inside the
application:

* Raise when invalid input indicates a configuration or programming error;
* Return `nil` when the caller is probing optional input;
* Supply a named default when the fallback is part of the documented
  application behaviour;
* Use a recovery block when diagnostics or a custom sentinel are required.

For a non-raising validation probe:

```Ruby
valid_port = Xqsr3::Quality::ParameterChecking.check_parameter(
  candidate,
  'port',
  type: Integer,
  values: [1..65_535],
  nothrow: true,
)

if valid_port
  puts "using port #{valid_port}"
else
  puts 'port was not accepted'
end
```

Be aware that `nothrow: true` uses `nil` as the failure signal. Do not use it
when `nil` is also a valid accepted value without adding a separate
presence check.

For conversion diagnostics:

```Ruby
port = Xqsr3::Conversion::IntegerParser.to_integer(
  candidate,
) do |exception, argument, base, options|
  warn "invalid port #{argument.inspect}: #{exception.message}"
  nil
end
```

The recovery block receives the original argument and conversion context.
Exceptions raised inside the block are not silently discarded.


## Build a normalized configuration

The following function combines the stages while retaining a simple
application-level result:

```Ruby
require 'xqsr3/conversion'
require 'xqsr3/quality/parameter_checking'
require 'xqsr3/string_utilities/nil_if_whitespace'

def load_configuration(environment)
  checker = Xqsr3::Quality::ParameterChecking
  string_utilities = Xqsr3::StringUtilities

  raw_host = environment.fetch('HOST', 'localhost')
  host = string_utilities::NilIfWhitespace
    .string_nil_if_whitespace(raw_host)
  host = checker.check_parameter(
    host,
    'host',
    type: String,
    reject_empty: true,
  )

  port = Xqsr3::Conversion::IntegerParser.to_integer(
    environment.fetch('PORT', '8080'),
  )
  port = checker.check_parameter(
    port,
    'port',
    type: Integer,
    values: [1..65_535],
  )

  enabled = Xqsr3::Conversion::BoolParser.to_bool(
    environment.fetch('ENABLED', 'false'),
  )
  enabled = checker.check_parameter(
    enabled,
    'enabled',
    types: [:boolean],
  )

  {
    enabled: enabled,
    host: host,
    port: port,
  }
end
```

This function rejects a blank host, an invalid port, and an unrecognised
Boolean token. It returns values in application-ready types rather than
leaving every downstream caller to repeat conversion logic.


## Further reading

* [Getting Started](./getting-started.md) for a first complete workflow;
* [Choosing a Component](./choosing-a-component.md) for selection guidance;
* [Conversion](../components/conversion.md) for parser policies;
* [Quality](../components/quality.md) for validation options;
* [String Utilities](../components/string-utilities.md) for normalization;
* [Diagnostics](../components/diagnostics.md) for failure context.


<!-- ########################### end of file ########################### -->
