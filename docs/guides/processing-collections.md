# xqsr3 Processing Collections <!-- omit in toc -->

This guide shows how to choose and combine xqsr3 collection helpers when
processing sequences, grouped values, and nested hashes.


## Table of Contents <!-- omit in toc -->

- [Count observations](#count-observations)
- [Group values by key](#group-values-by-key)
- [Find and transform an entry](#find-and-transform-an-entry)
- [Remove duplicates](#remove-duplicates)
- [Transform nested hashes](#transform-nested-hashes)
- [Match dynamic hash keys](#match-dynamic-hash-keys)
- [Choose the smallest abstraction](#choose-the-smallest-abstraction)


## Count observations

Use `FrequencyMap` when every observed item contributes to one numeric count:

```Ruby
require 'xqsr3/containers/frequency_map'

events = %w[read write read delete read]
frequencies = Xqsr3::Containers::FrequencyMap::ByElement[*events]

frequencies['read'] # => 3
frequencies.count   # => 5
frequencies.size    # => 3
```

Use `each_by_frequency` when output should be ordered by descending count:

```Ruby
frequencies.each_by_frequency do |event, count|
  puts "#{event}: #{count}"
end
```

The map retains the count for each distinct key. `count` is the total number
of observations; `size` is the number of keys.


## Group values by key

Use `MultiMap` when one key must retain several values:

```Ruby
require 'xqsr3/containers/multi_map'

files = Xqsr3::Containers::MultiMap.new
files.push :ruby, 'app.rb', 'config.rb'
files.push :test, 'app_test.rb'

files[:ruby] # => ['app.rb', 'config.rb']
files.size   # => 2
files.count  # => 3
```

`push` appends values, while `store` replaces the complete value array:

```Ruby
files.store :ruby, 'main.rb'
files[:ruby] # => ['main.rb']
```

An existing key may have an empty value array. This differs from an absent
key, for which indexing returns `nil`.


## Find and transform an entry

Use `Enumerable#detect_map` when the first matching value should immediately
be transformed and returned:

```Ruby
require 'xqsr3/extensions/enumerable/detect_map'

records = [
  { name: 'Ada', active: false },
  { name: 'Grace', active: true },
]

records.detect_map do |record|
  record[:name].upcase if record[:active]
end
# => 'GRACE'
```

Only `nil` means “continue searching”; `false` and `0` are valid successful
results. For hashes, use a two-argument block receiving the key and value.


## Remove duplicates

Use `Enumerable#unique` when the first occurrence should be retained:

```Ruby
require 'xqsr3/extensions/enumerable/unique'

values = [1, 2, 1, 3, 2]
values.unique
# => [1, 2, 3]
```

Without a block, uniqueness follows Ruby hash equality. With a two-argument
block, compare each candidate with the values already retained:

```Ruby
['Ada', 'ada', 'Grace'].unique do |kept, candidate|
  kept.downcase == candidate.downcase
end
# => ['Ada', 'Grace']
```

The first occurrence is retained and encounter order is preserved.
Comparator mode performs pairwise comparisons and is therefore less efficient
for large collections.


## Transform nested hashes

Use `Hash#deep_transform` when keys or key/value pairs must be transformed
through nested hashes:

```Ruby
require 'xqsr3/extensions/hash/deep_transform'

source = {
  user: {
    display_name: 'Ada',
  },
}

source.deep_transform { |key| key.to_s }
# => {'user' => {'display_name' => 'Ada'}}
```

Use a two-argument block to transform values as well:

```Ruby
source.deep_transform do |key, value|
  [key.to_s, value.is_a?(String) ? value.strip : value]
end
# => {'user' => {'display_name' => 'Ada'}}
```

The non-bang form returns a transformed copy. Use `deep_transform!` only when
in-place mutation is intended; a failed transformation can leave the
receiver partially transformed.


## Match dynamic hash keys

Use `Hash#has_match?` when only the presence of a matching key matters, and
`Hash#match` when its value is needed:

```Ruby
require 'xqsr3/extensions/hash/has_match'
require 'xqsr3/extensions/hash/match'

settings = {
  'service.host' => 'localhost',
  'service.port' => 8080,
}

settings.has_match?(/service\./) # => true
settings.match(/service\.port/)  # => 8080
```

Exact key matches take precedence. Matching a regular expression against
several keys follows hash iteration order. If a matching value may be `nil`,
use `has_match?` before interpreting `match`'s result.


## Choose the smallest abstraction

Use ordinary Ruby collection methods when they already express the operation
clearly. Add an xqsr3 component when it provides a meaningful additional
contract:

* Count observations with `FrequencyMap`;
* retain one-to-many values with `MultiMap`;
* combine detection and transformation with `detect_map`;
* retain first occurrences with `unique`;
* transform nested hashes with `deep_transform`;
* search dynamic keys with `match` or `has_match?`.

For more detail, see the [Containers](../components/containers.md),
[Hash Utilities](../components/hash-utilities.md), and
[Extensions](../components/extensions.md) component pages.


<!-- ########################### end of file ########################### -->
