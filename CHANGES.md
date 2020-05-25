# **xqsr3** Changes

## 0.36.0 - 26th May 2020

* added a number of files to simplify `require` statements:
  - **lib/xqsr3/all_extensions.rb**
  - **lib/xqsr3/array_utilities.rb**
  - **lib/xqsr3/command_line_utilities.rb**
  - **lib/xqsr3/containers.rb**
  - **lib/xqsr3/conversion.rb**
  - **lib/xqsr3/diagnostics.rb**
  - **lib/xqsr3/extensions.rb**
  - **lib/xqsr3/extensions/array.rb**
  - **lib/xqsr3/hash_utilities.rb**
  - **lib/xqsr3/string_utilities.rb**

## 25th May 2020

* CHANGES.md : improved markup

## 0.35.0 - 31st October 2019

* `::Xqsr3::IO.writelines()` / `::IO.writelines()` now recognises `:no_last_eol` option, which, if truey, suppresses the EOL on the last line/element in the written collection

## 0.34.0 - 4th July 2019

* added `Hash#slice` for Ruby versions < 2.5, available via **xqsr3/extensions/hash** (or **xqsr3/extensions/hash/slice**)

## 0.34.0 - 4th July 2019

* added `Hash#slice` for Ruby versions < 2.5, available via **xqsr3/extensions/hash** (or **xqsr3/extensions/hash/slice**)

## 0.33.0.1 - 15th April 2019

* further hiding of internal code from rdoc and yard

## 0.33.0 - 15th April 2019

* `MultiMap`:
  - added `#has_values?` method;
  - added `#multi_merge` and `#multi_merge!` methods;
  - added `#strict_merge` and `#strict_merge!` methods;
  - adding in missing (`TypeError`) parameter checks
* completing all outstanding missing documentation

## 0.32.3 - 12th April 2019

* comprehensive fixes to documentation

## 0.32.2 - 12th April 2019

* substantially improved performance of `Enumerable#unique()`
* fixes to `FrequencyMap`
* fixes to `MultiMap`

## 0.32.1 - 12th April 2019

* `FrequencyMap` : changed `@counts` => `@elements`

## 0.32.0 - 12th April 2019

* refactored `Xqsr3::Containers::FrequencyMap`, and corrected `#push()` to handle -ve count
* substantially improved documentation for some components (though many more to go)
* added **EXAMPLES.md** and the **examples/count_word_frequencies.rb** example


## previous versions

T.B.C.


