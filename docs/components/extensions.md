# xqsr3 Ruby Extensions <!-- omit in toc -->

Ruby extensions add focused methods to standard-library classes and modules.
They are useful when an operation reads naturally as a method on the value
being processed, but they also modify the method sets of those classes for the
rest of the process.

The extensions are opt-in. Choose the narrowest loading scope that suits the
application, particularly in gems and reusable libraries where global method
changes can surprise consumers.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a loading scope](#choosing-a-loading-scope)
- [Array extensions](#array-extensions)
- [Enumerable extensions](#enumerable-extensions)
- [Hash extensions](#hash-extensions)
- [Integer extensions](#integer-extensions)
- [IO extensions](#io-extensions)
- [Kernel extensions](#kernel-extensions)
- [String extensions](#string-extensions)
- [test/unit extensions](#testunit-extensions)
- [Extension design considerations](#extension-design-considerations)


## Loading

Load the standard-library extension groups:

```Ruby
require 'xqsr3/extensions'
```

This loads the Array, Enumerable, Hash, Integer, IO, Kernel, and String
groups. It does not load the `test/unit` extensions.

Load every extension, including test helpers, with:

```Ruby
require 'xqsr3/all_extensions'
```

Individual groups and methods can be loaded directly:

```Ruby
require 'xqsr3/extensions/enumerable'
require 'xqsr3/extensions/enumerable/detect_map'
```


## Choosing a loading scope

* Use a method-specific `require` when only one extension is needed;
* Use a class-group `require` when an application deliberately adopts several
  extensions for one standard-library type;
* Use `xqsr3/extensions` for an application that wants the standard-library
  extensions as a set;
* Use `xqsr3/all_extensions` in test runners or controlled application
  environments that also need the `test/unit` assertions;
* Avoid loading extensions implicitly from a reusable library's top-level
  entry point unless the global methods are part of that library's contract.


## Array extensions

`Array#join_with_or` formats an array as a human-readable list. The
standalone implementation and its extension are described in the
[Array Utilities](./array-utilities.md) page.

```Ruby
require 'xqsr3/extensions/array/join_with_or'

['red', 'green', 'blue'].join_with_or
```


## Enumerable extensions

The Enumerable extensions are:

* `collect_with_index(base = 0)`, which maps values while passing a
  base-adjusted index to the block;
* `detect_map`, which returns the first non-`nil` block result and therefore
  combines detection with transformation;
* `unique`, which retains the first occurrence of each distinct value and
  also supports a two-argument equality block.

```Ruby
require 'xqsr3/extensions/enumerable'

['a', 'b'].collect_with_index(1) { |value, index| "#{index}:#{value}" }
# => ['1:a', '2:b']

[1, 2, 3].detect_map { |value| value * 10 if value > 1 }
# => 20

[1, 2, 1, 3].unique
# => [1, 2, 3]
```

`detect_map` treats `false` and `0` as successful results; only `nil`
continues the search. Its block must have arity one for sequences or two for
key/value associations. `unique` without a block uses hash membership and
retains encounter order. Comparator mode is more expensive because retained
values are checked one at a time.


## Hash extensions

The Hash extensions are:

* `deep_transform` and `deep_transform!` for recursive value transformation;
* `except` and `except!` for removing named keys;
* `has_match?` and `match` for regular-expression-based key matching;
* `slice` for selecting named keys.

`except` returns a copy, while `except!` mutates the receiver. `slice` is
provided only where the Ruby version does not already define it; loading the
extension does not replace the native implementation.

```Ruby
require 'xqsr3/extensions/hash/except'

settings = { host: 'localhost', port: 80, secret: 'hidden' }
settings.except(:secret)
# => { host: 'localhost', port: 80 }
settings
# remains unchanged
```


## Integer extensions

`Integer#to_s_grp` formats an integer's decimal representation with grouping.
Pass the group width explicitly; a call without arguments returns the ordinary
decimal representation.

```Ruby
require 'xqsr3/extensions/integer/to_s_grp'

1234567.to_s_grp(3) # => '1,234,567'
```


## IO extensions

`IO.writelines` writes supplied contents to a path. It is useful when the
caller wants the library to handle opening and writing the output file.

```Ruby
require 'xqsr3/extensions/io/writelines'

IO.writelines('output.txt', ['first', 'second'])
```


## Kernel extensions

The Kernel extensions are:

* `Kernel::Integer`, which provides the xqsr3 integer conversion entry point;
* `Kernel#raise_with_options`, which raises option-aware exception classes.

The conversion and diagnostics pages describe their behaviour in detail.


## String extensions

The String extension group provides:

* `ends_with?` and `starts_with?`;
* `nil_if_empty` and `nil_if_whitespace`;
* `quote_if`;
* `to_bool` and `to_symbol`;
* `truncate`;
* `map_option_string`.

```Ruby
require 'xqsr3/extensions/string'

'user-name'.to_symbol       # => :user_name
'ruby language'.quote_if    # => '"ruby language"'
```

See [String Utilities](./string-utilities.md) for the matching, normalization,
quoting, symbol, and truncation semantics. `to_bool` and `map_option_string`
are documented with the other extension-specific APIs.


## test/unit extensions

The `test/unit` group adds assertions such as:

* `assert_eql`;
* `assert_false`;
* `assert_not`;
* `assert_not_eql`;
* `assert_raise_with_message`;
* `assert_subclass_of`;
* `assert_superclass_of`;
* `assert_true`;
* `assert_type_has_instance_methods`.

Load them explicitly in test code:

```Ruby
require 'xqsr3/extensions/test/unit'
```

These helpers are development/test conveniences and are not included by
`require 'xqsr3/extensions'`.


## Extension design considerations

Loading an extension changes a core Ruby class or module globally. This is
convenient for application code but can create name collisions and hidden
coupling between gems. Prefer narrow `require` paths in libraries and make
broader loading an explicit application decision.

The extension methods delegate to the standalone xqsr3 utilities where both
forms exist. This permits code to choose between explicit module calls and
method syntax without introducing a runtime dependency beyond the standard
Ruby library.

For executable behavioural examples, see the extension tests under
`test/unit/extensions/`.


<!-- ########################### end of file ########################### -->
