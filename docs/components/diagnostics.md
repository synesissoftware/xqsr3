# xqsr3 Diagnostics <!-- omit in toc -->

Diagnostics components help preserve useful context when a program fails.
They cover three related needs: raising option-aware exceptions, producing
consistent object inspection strings, and retaining an application-level
exception chain.

Use these components at boundaries where a generic Ruby exception would lose
information that a caller needs to diagnose or report a failure.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a diagnostic tool](#choosing-a-diagnostic-tool)
- [ExceptionUtilities](#exceptionutilities)
- [InspectBuilder](#inspectbuilder)
- [Exceptions::WithCause](#exceptionswithcause)
- [Design considerations](#design-considerations)


## Loading

Load all diagnostics components through the category entry point:

```Ruby
require 'xqsr3/diagnostics'
```

Or load only the required component:

```Ruby
require 'xqsr3/diagnostics/exception_utilities'
require 'xqsr3/diagnostics/inspect_builder'
require 'xqsr3/diagnostics/exceptions/with_cause'
```

The components are defined under `Xqsr3::Diagnostics`.


## Choosing a diagnostic tool

* Use `ExceptionUtilities` when an exception class accepts keyword options;
* Use `InspectBuilder` when diagnostic output should expose selected object
  state consistently;
* Use `Exceptions::WithCause` when an exception should retain a domain-level
  inner exception and report the chain;
* Use Ruby's native exception cause when the interpreter's raise-chain
  semantics, rather than an application-owned chain, are wanted.


## `ExceptionUtilities`

`Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options` preserves the
usual `Kernel#raise` forms and adds keyword options when the first argument is
an exception class. The options are passed to that class's constructor.

```Ruby
require 'xqsr3/diagnostics/exception_utilities'

class ConfigurationError < ArgumentError
  attr_reader :options

  def initialize(message = nil, **options)
    super(message)
    @options = options
  end
end

begin
  Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options(
    ConfigurationError,
    'invalid port',
    section: :server,
    value: 'abc',
  )
rescue ConfigurationError => error
  error.message # => 'invalid port'
  error.options # => { section: :server, value: 'abc' }
end
```

When no options are needed, the method behaves like `raise`:

```Ruby
Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options 'failure'
# raises RuntimeError
Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options ArgumentError
# raises ArgumentError
Xqsr3::Diagnostics::ExceptionUtilities.raise_with_options(
  ArgumentError,
  'failure',
)
```

The class must be the first argument for options to be meaningful. Supplying
options with a message, exception instance, or other non-class first argument
causes a warning and falls back to ordinary `Kernel#raise` behaviour.

The method preserves an explicitly supplied backtrace and trims the helper's
own internal frames. This keeps reported failures focused on the caller's
operation rather than on the implementation of `raise_with_options`.


## `InspectBuilder`

`Xqsr3::Diagnostics::InspectBuilder` is an includable module for classes that
need consistent `inspect`-style diagnostics. Its `make_inspect` method can
include class information, object identity, and instance fields:

```Ruby
require 'xqsr3/diagnostics/inspect_builder'

class Job
  include Xqsr3::Diagnostics::InspectBuilder

  def initialize(name, token)
    @name  = name
    @token = token
  end
end

job = Job.new('compile', 'secret')
job.make_inspect(show_fields: true, no_object_id: true)
# => "#<Job: @name(String)='compile'; @token(String)='secret'>"
```

The options are:

* `no_class` omits the class qualification;
* `no_object_id` omits the object identifier;
* `show_fields` includes instance variables;
* `shown_fields` restricts output to named fields;
* `hidden_fields` excludes named fields;
* `truncate_width` limits field values using the String Utilities truncation
  rules;
* `deep_inspect` obtains field values through their own `inspect` methods.

Field names may be supplied with or without the leading `@`. `shown_fields`
takes precedence over `hidden_fields`. A class can define
`INSPECT_HIDDEN_FIELDS` to establish default exclusions for its instances and
subclasses.

Use `shown_fields` or a class-level hidden-field list for secrets, credentials,
and other values that should not appear in logs. `inspect` output is a
diagnostic representation, not a serialization format.


## `Exceptions::WithCause`

`Xqsr3::Diagnostics::Exceptions::WithCause` is an inclusion module for custom
exception classes. It adds a `cause` attribute, preserves constructor options,
and exposes the chain through `chainees`, `exceptions`, `chained_message`, and
`chained_backtrace`.

```Ruby
require 'xqsr3/diagnostics/exceptions/with_cause'

class ImportError < StandardError
  include Xqsr3::Diagnostics::Exceptions::WithCause
end

begin
  begin
    raise ArgumentError, 'port is not numeric'
  rescue ArgumentError => cause
    raise ImportError.new('configuration is invalid', cause: cause)
  end
rescue ImportError => error
  error.message        # => 'configuration is invalid'
  error.cause.message  # => 'port is not numeric'
  error.chained_message # => 'configuration is invalid: port is not numeric'
  error.exceptions      # => [error, error.cause]
end
```

The `cause:` keyword is the clearest way to specify the inner exception. The
module can also infer an exception supplied among the positional constructor
arguments. When an exception is supplied without a separate outer message,
its message can become the outer exception's message.

`chained_message` uses `': '` between levels by default. Pass `separator` to
choose another separator:

```Ruby
error.chained_message(separator: ' <- ')
# => 'configuration is invalid <- port is not numeric'
```

`chainees` excludes the receiver; `exceptions` includes the receiver. Both
follow the cause chain in outer-to-inner order. `chained_backtrace` combines
the backtraces of the chain for diagnostic display.


## Design considerations

`WithCause#cause` is an application-level attribute and intentionally shadows
Ruby's interpreter-managed `Exception#cause` for classes that include the
module. Do not mix the two models casually in a single exception hierarchy.

Avoid putting secrets into exception messages or inspectable instance
variables. Prefer `InspectBuilder` field selection and explicit exception
options when diagnostic context must be retained without exposing everything
in logs.

For executable behavioural examples, see the unit tests in
`test/unit/diagnostics/` and `test/unit/diagnostics/exceptions/`.


<!-- ########################### end of file ########################### -->
