# xqsr3 Hash Utilities <!-- omit in toc -->

Hash utilities provide standalone operations for transforming and matching
hashes.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Components](#components)


## Loading

```Ruby
require 'xqsr3/hash_utilities'
```


## Components

### `HashUtilities::DeepTransform`

Transforms values recursively through nested hashes and collections.

```Ruby
require 'xqsr3/hash_utilities/deep_transform'
```

### `HashUtilities::KeyMatching`

Provides matching operations for hash keys.

```Ruby
require 'xqsr3/hash_utilities/key_matching'
```

Related extensions are available as `Hash#deep_transform`, `Hash#has_match?`,
`Hash#match`, `Hash#except`, and `Hash#slice`.


<!-- ########################### end of file ########################### -->
