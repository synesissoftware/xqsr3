# xqsr3 Diagnostics <!-- omit in toc -->

Diagnostics components provide small utilities for constructing, raising, and
inspecting exceptions.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Components](#components)


## Loading

```Ruby
require 'xqsr3/diagnostics'
```


## Components

### `Diagnostics::ExceptionUtilities`

Provides helpers for raising exceptions with additional options.

```Ruby
require 'xqsr3/diagnostics/exception_utilities'
```

### `Diagnostics::InspectBuilder`

Supports the construction of diagnostic inspection strings.

```Ruby
require 'xqsr3/diagnostics/inspect_builder'
```

### `Diagnostics::Exceptions::WithCause`

Represents an exception that retains an underlying cause.

```Ruby
require 'xqsr3/diagnostics/exceptions/with_cause'
```


<!-- ########################### end of file ########################### -->
