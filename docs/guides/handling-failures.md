# xqsr3 Handling Failures <!-- omit in toc -->

This guide shows how to make failures informative without coupling every
caller to the same recovery policy. It combines validation, option-aware
exceptions, inspection, and cause chaining.


## Table of Contents <!-- omit in toc -->

- [Reject invalid input early](#reject-invalid-input-early)
- [Attach structured context](#attach-structured-context)
- [Preserve the original cause](#preserve-the-original-cause)
- [Produce safe diagnostics](#produce-safe-diagnostics)
- [Choose a recovery boundary](#choose-a-recovery-boundary)


## Reject invalid input early

Validate values at the public boundary where their names and intended domain
are known:

```Ruby
require 'xqsr3/quality/parameter_checking'

def connect(port)
  port = Xqsr3::Quality::ParameterChecking.check_parameter(
    port,
    'port',
    type: Integer,
    values: [1..65_535],
  )

  # connect using the validated port
end
```

This produces a failure close to the invalid input instead of allowing an
unrelated lower-level operation to report a less useful error. Use
`nothrow: true` only when the caller genuinely needs a validation probe.


## Attach structured context

When an exception class accepts keyword options, use
`ExceptionUtilities.raise_with_options` to retain machine-readable context:

```Ruby
require 'xqsr3/diagnostics/exception_utilities'

class ConfigurationError < ArgumentError
  attr_reader :options

  def initialize(message = nil, **options)
    super(message)
    @options = options
  end
end

Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options(
  ConfigurationError,
  'invalid port',
  option: :port,
  value: 'abc',
)
```

Keep the human-readable message concise and put structured values in options.
Do not place credentials, tokens, or other secrets into either messages or
options if the exception may be logged.


## Preserve the original cause

Use `WithCause` when a higher-level operation needs to add context while
retaining the lower-level exception:

```Ruby
require 'xqsr3/diagnostics/exceptions/with_cause'

class ImportError < StandardError
  include Xqsr3::Diagnostics::Exceptions::WithCause
end

begin
  Integer('not-a-number')
rescue ArgumentError => cause
  raise ImportError.new('could not import configuration', cause: cause)
end
```

At the recovery boundary, the caller can inspect both levels:

```Ruby
rescue ImportError => error
  warn error.chained_message
  warn error.cause.class
end
```

`chained_message` combines messages from outer to inner exception. Pass
`separator` when another display format is required. `exceptions` returns the
whole chain; `chainees` returns every cause except the receiver.

Use the explicit `cause:` keyword when constructing a chain. This is clearer
than relying on positional exception inference and documents which exception
is intentionally being retained.


## Produce safe diagnostics

Use `InspectBuilder` when an object needs a stable diagnostic representation:

```Ruby
require 'xqsr3/diagnostics/inspect_builder'

class Request
  include Xqsr3::Diagnostics::InspectBuilder

  INSPECT_HIDDEN_FIELDS = ['token']

  def initialize(path, token)
    @path = path
    @token = token
  end
end

request = Request.new('/health', 'secret')
request.make_inspect(show_fields: true, no_object_id: true)
# => "#<Request: @path(String)='/health'>"
```

Use `shown_fields` for a positive allow-list when the object contains many
fields. A diagnostic inspection string is for human troubleshooting; it is
not a wire format or a persistence representation.


## Choose a recovery boundary

Apply recovery at the layer that has enough context to make a decision:

* A parser can return a default or `nil` for expected malformed input;
* A validator can raise a precise parameter or range failure;
* A component can wrap a lower-level error with `WithCause`;
* An application boundary can log, retry, or present the failure;
* A library should generally preserve the failure rather than silently log or
  discard it.

Avoid catching `Exception` broadly. Catch the specific failures the operation
can reasonably recover from, and preserve the original exception when adding
context.

For component-level details, see [Quality](../components/quality.md),
[Diagnostics](../components/diagnostics.md), and
[Conversion](../components/conversion.md).


<!-- ########################### end of file ########################### -->
