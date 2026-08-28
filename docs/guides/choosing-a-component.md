# xqsr3 Choosing a Component <!-- omit in toc -->

**xqsr3** is intentionally a collection of small, low-coupling components.
The quickest way to use it is to start with the problem being solved, then
load the narrowest component that provides the needed behaviour.


## Table of Contents <!-- omit in toc -->

- [Start with the data shape](#start-with-the-data-shape)
- [Start with the operation](#start-with-the-operation)
- [Decide between standalone and extension APIs](#decide-between-standalone-and-extension-apis)
- [Choose a loading scope](#choose-a-loading-scope)
- [Compose components at boundaries](#compose-components-at-boundaries)
- [Avoid common mismatches](#avoid-common-mismatches)
- [Further reading](#further-reading)


## Start with the data shape

Choose the component that matches the information the application already
has:

* A sequence whose members need counting: use
  [`FrequencyMap`](../components/containers.md#frequencymap);
* A key with several ordered values: use
  [`MultiMap`](../components/containers.md#multimap);
* A hash whose keys or values need recursive transformation: use
  [`DeepTransform`](../components/hash-utilities.md#deeptransform);
* A hash that must be searched by exact or regular-expression key: use
  [`KeyMatching`](../components/hash-utilities.md#keymatching);
* A string representing a scalar configuration value: use the
  [Conversion](../components/conversion.md) components;
* A list of alternatives intended for a person to read: use
  [`join_with_or`](../components/array-utilities.md#joinwithor).

Prefer the standard Ruby `Array`, `Hash`, or `Enumerable` APIs when the data
does not require one of these additional semantics.


## Start with the operation

If the desired operation is more important than the data structure, use these
shortcuts:

* Need to count occurrences? Use `FrequencyMap`;
* Need to group one key under many values? Use `MultiMap`;
* Need to parse `true`, `false`, `1`, or custom Boolean tokens? Use
  `BoolParser`;
* Need an integer with a base, fallback, or custom recovery? Use
  `IntegerParser`;
* Need to reject a value that is the wrong type, empty, or outside a range?
  Use `ParameterChecking`;
* Need to add a separator only when text contains whitespace? Use `quote_if`;
* Need to turn an identifier-like string into a symbol? Use `to_symbol`;
* Need to limit output width? Use `truncate`;
* Need to format alternatives with a final “or”? Use `join_with_or`;
* Need to write arrays or hashes as lines? Use `IO.writelines`;
* Need to add context to a failure? Use the
  [Diagnostics](../components/diagnostics.md) components;
* Need a method that combines detection and transformation? Use
  `Enumerable#detect_map`.


## Decide between standalone and extension APIs

Many xqsr3 facilities have two ways to be used:

* A standalone module or namespaced class keeps the call site explicit and
  avoids changing Ruby core classes;
* An extension method reads naturally on the receiver but changes the method
  set of a core class or module for the process.

Prefer standalone APIs inside reusable gems:

```Ruby
require 'xqsr3/conversion'
require 'xqsr3/hash_utilities/key_matching'

enabled = Xqsr3::Conversion::BoolParser.to_bool(value)
host = Xqsr3::HashUtilities::KeyMatching.match(settings, /host/)
```

Prefer extension APIs in an application that has explicitly adopted them:

```Ruby
require 'xqsr3/extensions/string'
require 'xqsr3/extensions/hash/match'

enabled = value.to_bool
host = settings.match(/host/)
```

Do not assume that requiring a standalone utility adds an instance method.
For example, `xqsr3/string_utilities/to_symbol` provides the
`StringUtilities::ToSymbol` module; `String#to_symbol` requires the matching
extension.


## Choose a loading scope

Use the narrowest require path that communicates the dependency:

* `xqsr3/<category>` loads the standalone components in that category;
* `xqsr3/<category>/<component>` loads one standalone component;
* `xqsr3/extensions/<class>` loads extensions for one core class or module;
* `xqsr3/extensions/<class>/<method>` loads one extension method;
* `xqsr3/extensions` loads the standard-library extension groups;
* `xqsr3/all_extensions` also loads the `test/unit` extensions.

The broad extension entry points are convenient but create global method
changes. A reusable library should generally avoid requiring them as a side
effect of its own top-level load.


## Compose components at boundaries

A useful composition order is:

1. Convert external text into an application value;
2. Validate the converted value and its domain;
3. Store or transform the value using the matching data structure;
4. Format or write the result;
5. Add diagnostic context if a step fails.

For example, configuration processing can convert and validate a port before
writing a normalized summary:

```Ruby
require 'xqsr3/conversion'
require 'xqsr3/quality/parameter_checking'
require 'xqsr3/io/writelines'

port = Xqsr3::Conversion::IntegerParser.to_integer(
  ENV.fetch('PORT', '8080'),
)
port = Xqsr3::Quality::ParameterChecking.check_parameter(
  port,
  'port',
  type: Integer,
  values: [1..65_535],
)

Xqsr3::IO.writelines('effective-config.txt', { port: port })
```

This keeps parsing policy, validation policy, storage, and output concerns
separate. It also makes each policy independently testable.


## Avoid common mismatches

* Do not use `FrequencyMap` when values, rather than counts, must be retained;
  use `MultiMap`;
* Do not use `MultiMap` as a set: duplicate values are retained;
* Do not use `BoolParser` as a strict validator without checking its fallback
  result;
* Do not use `IntegerParser` with a base expecting non-string numbers to be
  reinterpreted;
* Do not use `deep_transform!` when a failed transformation must leave the
  original hash untouched;
* Do not treat `Hash#match` returning `nil` as proof that no key matched if a
  matching value may itself be `nil`;
* Do not load all extensions merely to use one String or Hash method;
* Do not use `IO.writelines` as a replacement for a serializer that must
  escape or encode structured data.


## Further reading

* [Getting Started](./getting-started.md) for a complete first workflow;
* [Component Catalogue](../components/README.md) for category-level detail;
* [Containers](../components/containers.md) for collection choices;
* [Conversion](../components/conversion.md) for scalar parsing;
* [Diagnostics](../components/diagnostics.md) for failure context;
* [Extensions](../components/extensions.md) for loading and global methods;
* [Hash Utilities](../components/hash-utilities.md) for hash operations;
* [IO](../components/io.md) for structured output;
* [Quality](../components/quality.md) for validation;
* [String Utilities](../components/string-utilities.md) for string handling.


<!-- ########################### end of file ########################### -->
