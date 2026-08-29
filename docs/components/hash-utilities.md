# xqsr3 Hash Utilities <!-- omit in toc -->

Hash utilities provide explicit operations for recursively transforming hash
keys and values, and for finding entries through exact or regular-expression
matching.

Use the utility modules when a library should avoid loading global `Hash`
extensions. The corresponding extensions are available when method syntax is
preferable.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a utility](#choosing-a-utility)
- [DeepTransform](#deeptransform)
- [KeyMatching](#keymatching)
- [Hash extensions](#hash-extensions)
- [Safety and ordering](#safety-and-ordering)


## Loading

Load both utility modules through the category entry point:

```Ruby
require 'xqsr3/hash_utilities'
```

Or load only the required utility:

```Ruby
require 'xqsr3/hash_utilities/deep_transform'
require 'xqsr3/hash_utilities/key_matching'
```

The utility modules are defined in `Xqsr3::HashUtilities` and are includable
in hash-like classes.


## Choosing a utility

* Use `DeepTransform` to apply a key or key/value transformation through
  nested hashes;
* Use `KeyMatching#match` to retrieve the first matching value;
* Use `KeyMatching#has_match?` when only the existence of a match matters;
* Use `deep_transform` when the original hash must remain unchanged;
* Use `deep_transform!` only when in-place transformation is intentional and
  partial mutation on failure is acceptable.


## `DeepTransform`

`Xqsr3::HashUtilities::DeepTransform` provides `deep_transform` and
`deep_transform!`. Both require a block with arity one or two:

* A one-argument block transforms keys;
* A two-argument block transforms a key and value and must return the
  replacement key/value pair.

The non-bang method returns a new hash:

```Ruby
require 'xqsr3/extensions/hash/deep_transform'

input = {
  user: {
    name: 'Ada',
  },
}

result = input.deep_transform { |key| key.to_s.upcase }

result # => {'USER' => {'NAME' => 'Ada'}}
input  # => {:user => {:name => 'Ada'}}
```

The one-argument form transforms keys, not values. Use the two-argument form
to transform values:

```Ruby
result = input.deep_transform do |key, value|
  [key.to_s, value.is_a?(String) ? value.strip : value]
end

result # => {'user' => {'name' => 'Ada'}}
```

Nested hashes are transformed recursively. Other nested collection types are
treated as values and are not traversed by this utility.

The bang form changes the receiver and returns it:

```Ruby
input = { user: { name: ' Ada ' } }

input.deep_transform! do |key, value|
  [key, value.is_a?(String) ? value.strip : value]
end

input # => { user: { name: 'Ada' } }
```

The block is mandatory. A block with any arity other than one or two raises
`ArgumentError`. The non-bang form requires a hash-like object responding to
`map`; the bang form requires an object supporting `[]=`, `delete`, and
`keys`.


## `KeyMatching`

`Xqsr3::HashUtilities::KeyMatching` provides `match` and `has_match?` in both
standalone and includable forms. A direct key match is checked first:

```Ruby
require 'xqsr3/hash_utilities/key_matching'

settings = {
  'database.host' => 'db.example.test',
  'database.port' => 5432,
}

Xqsr3::HashUtilities::KeyMatching.match(settings, 'database.port')
# => 5432
Xqsr3::HashUtilities::KeyMatching.has_match?(settings, 'database')
# => false
Xqsr3::HashUtilities::KeyMatching.has_match?(settings, /database\./)
# => true
```

When the search argument is a `Regexp`, ordinary keys are converted to strings
and tested against it. `match` returns the value for the first matching key,
or `nil`; `has_match?` returns `true` or `false`.

Hashes may themselves contain regular-expression keys. When the search
argument is not a `Regexp`, those expression keys are tested against the
string form of the search argument:

```Ruby
rules = {
  /staging|production/ => :remote,
  /development/       => :local,
}

Xqsr3::HashUtilities::KeyMatching.match(rules, :production)
# => :remote
```

Because `match` returns the matching value, a matching entry whose value is
`nil` is indistinguishable from no match through the return value alone. Use
`has_match?` when that distinction matters.


## Hash extensions

The standalone utilities can be applied to `Hash` through the corresponding
extension files:

```Ruby
require 'xqsr3/extensions/hash/deep_transform'
require 'xqsr3/extensions/hash/has_match'

{ 'a' => 1 }.deep_transform { |key| key.to_sym }
# => {:a => 1}
```

The complete Hash extension group additionally provides:

* `except`, which returns a copy without selected keys;
* `except!`, which removes selected keys from the receiver;
* `match` and `has_match?`;
* `slice`, which selects existing keys into a new hash.

`slice` is loaded only on Ruby versions that do not already provide the
native method.


## Safety and ordering

`deep_transform` is the safer default when a transformation may fail because
the original receiver remains unchanged. `deep_transform!` is not strongly
exception-safe: an exception can leave the receiver partially transformed.

Matching follows hash iteration order after the exact-key check. For
regular-expression searches, the first matching key determines the result;
overlapping expressions should therefore be ordered deliberately.

For executable behavioural examples, see the unit tests in
`test/unit/hash_utilities/` and the related Hash extension tests.


<!-- ########################### end of file ########################### -->
