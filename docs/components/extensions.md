# xqsr3 Ruby Extensions <!-- omit in toc -->

Ruby extensions add focused methods to standard-library classes and modules.
They are grouped by the class or module they extend.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Extension groups](#extension-groups)


## Loading

```Ruby
require 'xqsr3/extensions'
```

Individual extension groups and methods can be loaded directly.


## Extension groups

* [Array extensions](#array-extensions);
* [Enumerable extensions](#enumerable-extensions);
* [Hash extensions](#hash-extensions);
* [Integer extensions](#integer-extensions);
* [IO extensions](#io-extensions);
* [Kernel extensions](#kernel-extensions);
* [String extensions](#string-extensions);
* [test/unit extensions](#testunit-extensions);

The group-specific APIs are documented in the generated API reference and
will be expanded here with examples and behavioural details.


### Array extensions

Provides `Array#join_with_or`.


### Enumerable extensions

Provides `Enumerable#collect_with_index`, `Enumerable#detect_map`, and
`Enumerable#unique`.


### Hash extensions

Provides deep transformation, matching, slicing, and exception-style
operations for hashes.


### Integer extensions

Provides `Integer#to_s_grp`.


### IO extensions

Provides `IO#writelines`.


### Kernel extensions

Provides `Kernel::Integer` and `Kernel#raise_with_options`.


### String extensions

Provides string predicates, conversions, formatting, and truncation helpers.


### test/unit extensions

Provides additional assertions for `test-unit`, including type and exception
assertions.


<!-- ########################### end of file ########################### -->
