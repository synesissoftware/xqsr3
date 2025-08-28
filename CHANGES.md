# **xqsr3** Changes


## 0.39.4 - 29th August 2025

* warnings;


## 0.39.3.2 - 29th August 2025

* boilerplate;
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts);


## 0.39.3.1 - 6th March 2025

* warnings


## 0.39.3 - 27th July 2024

* minor fixes


## 0.39.2.1 - 12th April 2024

* wholesale documentation improvements


## 0.39.2 - 12th April 2024

* fixed conditional definition / overriding of `Test::Unit::Assertions` assertion methods
* fix to `IO.writelines()` extension method
* various warnings fixed
* settings (fix)
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts)


## 0.39.1 - 30th March 2024

* extends `Integer` class with the `#to_s_grp()` method
* canonicalising whitespace and file format


## 0.39.0 - 29th March 2024

* added `Integer#to_s_grp` extension method, available via **xqsr3/extensions/integer** (or **xqsr3/extensions/integer/to_s_grp**)


## 0.38.2 - 1st December 2023

* `check_parameter()` : ~ execution of block (if given) now occurs _before_ value check, rather than after


## 0.38.1.1 - 1st December 2023

* improved documentation


## 0.38.1 - 26th July 2022

* ensuring all `Xqsr3::Containers::FrequencyMap` `each` methods work with and without block


## 0.38.0 - 25th July 2022

* various enhancements to `Xqsr3::Quality::ParameterChecking` module


## 0.37.3 - 19th July 2022

* added `NilClass#map_option_string` extension method, available via **xqsr3/extensions/string/map_option_string**


## 0.37.2 - 26th June 2022

* Ruby 3.x compatibility in gemspec


## 0.37.1 - 25th June 2022

* compatibility with Ruby 3.x for `Hash#except` and `#except!`


## 0.37.0 - 20th April 2021

* added `Hash#except` extension method, available via **xqsr3/extensions/hash** (or **xqsr3/extensions/hash/except**)


## 0.36.1.1 - 20th September 2020

* fixes to unit-tests of `tc_raise_with_options` to ensure works on Windows


## 0.36.1 - 2nd June 2020

* Ruby 2.7 compatibility - avoiding deprecation warning when Hash used in keyword arguments context


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


<!-- ########################### end of file ########################### -->

