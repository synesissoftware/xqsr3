# xqsr3 Containers <!-- omit in toc -->

The container components provide focused collection types for common
counting and key-to-multiple-value use cases.

Use `FrequencyMap` when each key has one numeric count. Use `MultiMap` when
each key has an ordered collection of values. Both preserve the distinction
between the number of keys and the number of associated items.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Choosing a container](#choosing-a-container)
- [FrequencyMap](#frequencymap)
- [MultiMap](#multimap)
- [Shared conventions](#shared-conventions)


## Loading

Load both containers through the category entry point:

```Ruby
require 'xqsr3/containers'
```

Or load only the component required by the application:

```Ruby
require 'xqsr3/containers/frequency_map'
require 'xqsr3/containers/multi_map'
```

The classes are defined in `Xqsr3::Containers`.


## Choosing a container

* Choose `FrequencyMap` for histograms, frequency tables, and tallying;
* Choose `MultiMap` for one-to-many relationships and grouped values;
* Choose a regular `Hash` when neither counting nor one-to-many behaviour is
  required.


## `FrequencyMap`

`Xqsr3::Containers::FrequencyMap` maps each element to a numeric count. It
includes `Enumerable`, and its `count` method returns the total number of
observations, while `size` returns the number of distinct elements.

```Ruby
require 'xqsr3/containers/frequency_map'

frequencies = Xqsr3::Containers::FrequencyMap::ByElement[
  'ruby', 'ruby', 'crystal', 'ruby',
]

frequencies['ruby']    # => 3
frequencies['crystal'] # => 1
frequencies['python']  # => 0
frequencies.size       # => 2
frequencies.count      # => 4
```

`ByElement[...]` is the convenient constructor when starting with a sequence
of observations. `FrequencyMap[...]` also accepts a `Hash`, an array of
`[key, count]` pairs, or an even-length key/count array.

The primary mutation methods are:

* `push(key, count = 1)` adds to the existing count and removes the key when
  the resulting count is zero;
* `store(key, count)` replaces the existing count and removes the key when
  `count` is zero;
* `<< key` records one observation;
* `delete(key)` removes the key and its contribution to the total;
* `merge` and `merge!` combine counts for duplicate keys.

Counts must be integers. A push that would make an individual count negative
raises `RangeError`; invalid count values raise `TypeError`.

Useful queries include `each`, `each_by_key`, `each_by_frequency`, `fetch`,
`has_key?`, `has_value?`, `key`, `keys`, `values`, `to_a`, and `to_h`.
Indexing an absent key returns zero, whereas `fetch` can return a supplied
default, invoke a block, or raise `KeyError`.


## `MultiMap`

`Xqsr3::Containers::MultiMap` maps each key to an array of values. It includes
`Enumerable`, and its `size` is the number of keys while `count` is the total
number of stored values.

```Ruby
require 'xqsr3/containers/multi_map'

groups = Xqsr3::Containers::MultiMap.new
groups.push :ruby, 'MRI', 'JRuby'
groups.push :ruby, 'TruffleRuby'
groups.push :python, 'CPython'

groups[:ruby]   # => ['MRI', 'JRuby', 'TruffleRuby']
groups[:python] # => ['CPython']
groups.size     # => 2
groups.count    # => 4
```

Pushing a key with no values still creates the key and associates it with an
empty array. Indexing an absent key returns `nil`, which differs from an
existing key whose value array is empty.

The primary mutation methods are:

* `push(key, *values)` appends values to the key's existing array;
* `store(key, *values)` replaces the key's value array;
* `delete(key)` removes all values mapped to the key;
* `multi_merge` and `multi_merge!` concatenate values for duplicate keys;
* `strict_merge` and `strict_merge!` replace values for duplicate keys.

`MultiMap[...]` accepts a `Hash` whose values are arrays, an array of
`[key, value, ...]` entries, or multiple such entries. `each` yields one
`[key, value]` pair for every stored value. Use `each_unflattened` when the
value array must be yielded as a whole.


## Shared conventions

Both containers provide `assoc`, `clear`, `delete`, `each_key`, `fetch`,
`flatten`, `has_key?`, `keys`, `length`, `shift`, `size`, `to_a`, `to_hash`,
and `values`-style operations. Both support `dup`, equality comparison with
their corresponding `Hash` representation, and enumerator-returning methods
when no block is supplied.

The containers retain insertion order through their underlying Ruby hashes.
Methods explicitly described as sorted—`FrequencyMap#each_by_key` and
`FrequencyMap#each_by_frequency`—perform ordering work at enumeration time.

For executable behavioural examples, see the unit tests in
`test/unit/containers/`.


<!-- ########################### end of file ########################### -->
