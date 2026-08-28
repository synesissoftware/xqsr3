# xqsr3 String Utilities <!-- omit in toc -->

String utilities provide standalone predicates, normalisation, conversion,
quoting, and truncation operations.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Components](#components)


## Loading

```Ruby
require 'xqsr3/string_utilities'
```

Individual components can also be loaded directly.


## Components

* `StringUtilities::EndsWith`;
* `StringUtilities::NilIfEmpty`;
* `StringUtilities::NilIfWhitespace`;
* `StringUtilities::QuoteIf`;
* `StringUtilities::StartsWith`;
* `StringUtilities::ToSymbol`;
* `StringUtilities::Truncate`;

The corresponding standard-library extensions include
`String#ends_with?`, `String#nil_if_empty`, `String#nil_if_whitespace`,
`String#quote_if`, `String#starts_with?`, `String#to_bool`, `String#to_symbol`,
and `String#truncate`.


<!-- ########################### end of file ########################### -->
