# xqsr3 - Changes <!-- omit in toc -->


## 0.39.9 - 21st August 2026

* `IO.writelines` writes via `<<` of `to_s` fragments instead of interpolating into frozen strings (Ruby 3.4+ `-W`);
* writelines unit tests use `StringIO.new(+'', …)` so the destination buffer is not a frozen literal;
* **test/unit/quality/tc_parameter_checking.rb**: `check_method_2` forwards the validation block; `assert_nil` / `assert_not_nil` invocations wrapped so **test-unit** does not warn under Ruby 3.4;
* library source **Home:** URLs now use `https`;
* **EXAMPLES.md** example links are repo-relative (`./examples/…`);
* updated **README.md** afferent (fan-in) dependent lists;
* expanded **xqsr3.gemspec** `spec.summary` to the README tagline; packaged **CONTRIBUTING**, **FAQ**, **INSTALL**, and **SECURITY**;
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts) to skip **tput** when **$TERM** is unset or stdout is not a TTY;
* CI **Warnings** job now runs on Ruby **3.4**;
* regenerated **Gemfile.lock** for **0.39.9**;


## 0.39.8 - 20th August 2026

* added `# frozen_string_literal: true` to all **lib/** sources;
* **Rakefile**: `# frozen_string_literal: true` and `test` on the load path;
* polished **xqsr3.gemspec** (standard File/Purpose/Created/Updated banner; multi-line `authors` / `email`);
* added **.editorconfig**;
* added **.github/dependabot.yml** (bundler and GitHub Actions, weekly);
* **.gitattributes**: **Gemfile.lock** is now a normal text file (no longer `-diff`); regenerated lockfile with path gem and **rake** / **test-unit** pins;
* updated CI in **.github/workflows/ruby.yml** (`rc1`/`rc2`/`rc3` branch triggers; `fail-fast: false`; default `bash` shell; remove **Gemfile.lock** before `setup-ruby`);
* added **CONTRIBUTING.md**, **INSTALL.md**, and **SECURITY.md**; populated **FAQ.md**;
* reformatted **AUTHORS.md** as tables;
* backfilled historical **NEWS.md** release rows and **CHANGES.md** version entries;
* updated **Gemfile** dependency quote style (double-quoted gem names, single-quoted constraints);


## 0.39.7 - 19th August 2026

* fixed **MultiMap**: no longer subclasses +Hash+ (data lived only in +@inner+, so inherited +keys+/+key?+ lied); added +keys+/+key?+/+include?+/+member?+; fixed +to_hash+; deep-copy on +dup+/+clone+; +MultiMap[]+ no longer mutates nested arrays; Hash merges splat array values consistently with +MultiMap[]+ / +to_h+;
* fixed `IO.writelines` Hash EOL lookahead (+each_with_index+ was not destructuring key/value pairs);
* aligned `xqsr3/extensions` (and thus `xqsr3/all_extensions`) with documented extension packs — now loads **integer**, **kernel**, and **string** as well as **enumerable/detect_map**;
* fixed **FrequencyMap** (+#store(0)+ removes key; +#to_h+/+#to_hash+ return copies; +#[]+ / +#each_by_key+ docs);
* fixed **ParameterChecking** (+#ignore_order+ recognised; +:types+ no longer mutates caller array) and **join_with_or** (+treat_as_option:+);
* fixed `Enumerable#detect_map` to return falsy hits (+nil+ means continue);
* fixed `Integer#to_s_grp` to honour +:separator+ for the single-group path;
* fixed `ExceptionUtilities.raise_with_options` to use +set_backtrace+ instead of deprecated 3-arg +raise+; documented **WithCause** +#cause+ shadowing;


## 0.39.6 - 18th August 2026

* fixed **BoolParser** default matching to require whole-string `true`/`false` (case-insensitive), aligned `:default_value` / `:true_value` / `:false_value` options with documented names (legacy `:default` / `:true` / `:false` still accepted), and allowed falsy override values;
* fixed `Kernel#Integer` extension to honour the supplied +base+ (was always forced to +0+);
* fixed `Enumerable#unique` to honour its optional two-parameter equality comparator block;
* fixed `Hash#deep_transform!` (+NameError+ on +self+ check; arity-2 results were not written back);
* fixed `String#starts_with?` / `String#ends_with?` (+StringUtilities+) +to_str+ candidate path (was +s.prefix.to_str+);
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts);
* fixed Windows CI by running **Gemfile.lock** removal under `bash` (`rm -f` is not valid PowerShell);


## 0.39.5 - 14th August 2026

* removed `< 4` upper bound from `required_ruby_version` in **xqsr3.gemspec**;


## 0.39.4.1 - 12th August 2026

* updated **LICENSE** to canonical BSD-3-Clause form (copyright through 2026);
* rewritten **.gitattributes** for Ruby (EOL, diff, Linguist);
* updated CI branch triggers in **.github/workflows/ruby.yml**;
* wired **Gemfile** to `gemspec` with explicit **rake** / **test-unit** (Ruby-version-aware **rake** pins); removed obsolete gemspec `rake '~> 2'` development dependency;
* extended **.github/workflows/ruby.yml** with gem build/install smoke on the test matrix and a Ubuntu/**3.3** warnings job;
* reordered **README.md** (tagline before badges), added **Dependencies** (Efferent / Afferent), and lexicographically sorted related-project lists;
* added **TODO.md**, **NEWS.md**, and **AUTHORS.md**; normalised **CHANGES.md** bullets and removed legacy "previous versions / T.B.C." stub;
* polished **xqsr3.gemspec** (`https` homepage, Rubygems `metadata` URIs, dropped `Date.today`, package **AUTHORS**/**CHANGES**/**EXAMPLES**/**NEWS**/**TODO**);
* boilerplate (**CHANGES.md**, **EXAMPLES.md**, **.gitignore**, **.vscode/settings.json**);


## 0.39.4 - 29th August 2025

* GitHub Actions;
* Rakefile;
* Ruby 3.4 compatibility;
* warnings;


## 0.39.3.2 - 29th August 2025

* boilerplate;
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts);


## 0.39.3.1 - 6th March 2025

* warnings;


## 0.39.3 - 27th July 2024

* minor fixes;


## 0.39.2.1 - 12th April 2024

* wholesale documentation improvements;


## 0.39.2 - 12th April 2024

* fixed conditional definition / overriding of `Test::Unit::Assertions` assertion methods;
* fix to `IO.writelines()` extension method;
* various warnings fixed;
* settings (fix);
* updated **run_all_unit_tests.sh** (from https://github.com/synesissoftware/misc-dev-scripts);


## 0.39.1 - 30th March 2024

* extends `Integer` class with the `#to_s_grp()` method;
* canonicalising whitespace and file format;


## 0.39.0 - 29th March 2024

* added `Integer#to_s_grp` extension method, available via **xqsr3/extensions/integer** (or **xqsr3/extensions/integer/to_s_grp**);


## 0.38.2 - 1st December 2023

* `check_parameter()` : ~ execution of block (if given) now occurs _before_ value check, rather than after;


## 0.38.1.1 - 1st December 2023

* improved documentation;


## 0.38.1 - 26th July 2022

* ensuring all `Xqsr3::Containers::FrequencyMap` `each` methods work with and without block;


## 0.38.0 - 25th July 2022

* various enhancements to `Xqsr3::Quality::ParameterChecking` module;


## 0.37.3 - 19th July 2022

* added `NilClass#map_option_string` extension method, available via **xqsr3/extensions/string/map_option_string**;


## 0.37.2 - 26th June 2022

* Ruby 3.x compatibility in gemspec;


## 0.37.1 - 25th June 2022

* compatibility with Ruby 3.x for `Hash#except` and `#except!`;


## 0.37.0 - 20th April 2021

* added `Hash#except` extension method, available via **xqsr3/extensions/hash** (or **xqsr3/extensions/hash/except**);


## 0.36.1.1 - 20th September 2020

* fixes to unit-tests of `tc_raise_with_options` to ensure works on Windows;


## 0.36.1 - 2nd June 2020

* Ruby 2.7 compatibility - avoiding deprecation warning when Hash used in keyword arguments context;


## 0.36.0 - 26th May 2020

* added a number of files to simplify `require` statements:
	* **lib/xqsr3/all_extensions.rb**;
	* **lib/xqsr3/array_utilities.rb**;
	* **lib/xqsr3/command_line_utilities.rb**;
	* **lib/xqsr3/containers.rb**;
	* **lib/xqsr3/conversion.rb**;
	* **lib/xqsr3/diagnostics.rb**;
	* **lib/xqsr3/extensions.rb**;
	* **lib/xqsr3/extensions/array.rb**;
	* **lib/xqsr3/hash_utilities.rb**;
	* **lib/xqsr3/string_utilities.rb**;
* improved **CHANGES.md** markup (25th May 2020);


## 0.35.0 - 31st October 2019

* `::Xqsr3::IO.writelines()` / `::IO.writelines()` now recognises `:no_last_eol` option, which, if truey, suppresses the EOL on the last line/element in the written collection;


## 0.35 - 31st October 2019

* ::Xqsr3::IO.writelines() / ::IO.writelines() : + now recognises ':no_last_eol' option, which, if truey, suppresses the EOL on the last line/element in the written collection;


## 0.34.0 - 4th July 2019

* added `Hash#slice` for Ruby versions < 2.5, available via **xqsr3/extensions/hash** (or **xqsr3/extensions/hash/slice**);


## 0.33.0.1 - 15th April 2019

* further hiding of internal code from rdoc and yard;


## 0.33.0 - 15th April 2019

* `MultiMap`:
	* added `#has_values?` method;
	* added `#multi_merge` and `#multi_merge!` methods;
	* added `#strict_merge` and `#strict_merge!` methods;
	* adding in missing (`TypeError`) parameter checks;
* completing all outstanding missing documentation;


## 0.32.3 - 12th April 2019

* comprehensive fixes to documentation;


## 0.32.2 - 12th April 2019

* substantially improved performance of `Enumerable#unique()`;
* fixes to `FrequencyMap`;
* fixes to `MultiMap`;


## 0.32.1 - 12th April 2019

* `FrequencyMap` : changed `@counts` => `@elements`;


## 0.32.0 - 12th April 2019

* refactored `Xqsr3::Containers::FrequencyMap`, and corrected `#push()` to handle -ve count;
* substantially improved documentation for some components (though many more to go);
* added **EXAMPLES.md** and the **examples/count_word_frequencies.rb** example;


## 0.31.3 - 12th April 2019

* fixing up documentation;


## 0.31.2 - 10th April 2019

* tidying documentation;


## 0.31.1 - 13th March 2019

* fixing up warnings;


## 0.31.0 - 2nd March 2019

* added Gemfile (which is empty, since xqsr3 has no dependencies);


## 0.30.3 - 28th February 2019

* merge;


## 0.30.2 - 19th October 2018

* addressing warnings;


## 0.30.1 - 13th October 2018

* FrequencyMap : + added #each_by_key();


## 0.29.2 - 13th October 2018

* tagged release;


## 0.28.2 - 14th September 2018

* InspectBuilder: + now supports including class having INSPECT_HIDDEN_FIELDS constant;


## 0.28.1 - 5th September 2018

* merging in InspectBuilder;


## 0.28.0 - 5th September 2018

* Xqsr3::Quality::ParameterChecking : + now accepts pseudo-type :boolean, in the stead of ::TrueClass + ::FalseClass;


## 0.27.2 - 4th September 2018

* whitespace;


## 0.27.1 - 8th August 2018

* added ::Xqsr3::XML::Utilities::Navigation module; ~ fixed content-comparison in xml_compare();


## 0.26.4 - 1st August 2018

* Xqsr3::Conversion::IntegerParser : ~ improved handling of corner cases;


## 0.26.3 - 30th July 2018

* tidying;


## 0.26.2 - 17th July 2018

* ::Xqsr3::Conversion::IntegerParser : ::to_integer() and #to_integer() : ~ block now takes (up to) 4-parameters : exception, arg, base, options;


## 0.26.1 - 17th July 2018

* added ::Xqsr3::Conversion::IntegerParser, which has ::to_integer() and #to_integer(), and reimplemented the Kernel#Integer() in terms of it;


## 0.25.2 - 17th July 2018

* fixed missing equivalence of ':allow_nil' and ':nil' options;


## 0.25.1 - 18th May 2018

* Kernel#Integer() extension : + added caller-supplied block;


## 0.24.1 - 12th April 2018

* added Xqsr3::Extensions::String::Truncate module and extension method #truncate() for String;


## 0.23.2 - 9th April 2018

* Xqsr3::Quality::ParameterChecking#check_parameter : ~ now does not check empty? if value.nil?; assert_raise_with_exception() : + now includes exception message when wrong exception type;


## 0.22.7 - 21st March 2018

* ::Xqsr3::Quality::ParameterChecking : + now warns about unrecognised options (when );


## 0.22.6 - 21st March 2018

* assert_raise_with_message() : ~ fixed defect that was hiding the message 'the block did not throw an exception as was expected';


## 0.22.5 - 14th March 2018

* run_all_unit_tests(.sh) : + added '--debug', '--help', and '--separate' flags;


## 0.22.4 - 28th February 2018

* cleaning gemspec;


## 0.22.3 - 28th February 2018

* ::Xqsr3::XML::Utilities::Compare::xml_compare() : ~ now ignores XML Declarations so that XML documents and nodes may be compared without Declarations getting in the way;


## 0.22.2 - 1st February 2018

* ::Xqsr3::XML::Utilities::Compare::Result : + overridden to_s() to return 'same' or 'different, because: .... details ...';


## 0.22.1 - 25th January 2018

* version;


## 0.21.3 - 8th January 2018

* more unit tests for ::Xqsr3::Quality::ParameterChecking;


## 0.21.2 - 8th January 2018

* merging 0.20.3;


## 0.21.1 - 6th January 2018

* added assert_type_has_instance_methods() extension method (for Test::Unit);


## 0.20.3 - 8th January 2018

* ::Xqsr3::Quality::ParameterChecking::check_parameter() : ~ fix to allow types to contain nested arrays along with non-array type(s);


## 0.20.2 - 2nd January 2018

* ::Xqsr3::Quality::ParameterChecking::check_parameter() : ~ fix to allow types to contain nested arrays along with non-array type(s);


## 0.20.1 - 22nd December 2017

* added assert_raise_with_message();


## 0.19.3 - 21st December 2017

* tidying;


## 0.19.2 - 21st December 2017

* tagged release;


## 0.19.1 - 21st December 2017

* tagged release;


## 0.18.1 - 17th December 2017

* added Xqsr3::Diagnostics::Exceptions::WithCase inclusion module, which enables an exception class to be able to receive a cause (inner exception) in its initialiser, which is then exposed via a +cause+ attribute (along with +chainees+, +exceptions+, +chained_backtrace+, and +chained_message+ attributes);


## 0.17.2 - 16th December 2017

* tidying;


## 0.17.1 - 9th December 2017

* added Enumerable#detect_map() extension method;


## 0.16.1 - 7th December 2017

* added ::Xqsr3::ArrayUtilities::JoinWithOr module, with join_with_or() method;


## 0.15.3 - 7th December 2017

* Xqsr3::Quality::ParameterChecking : ~ ensuring that class methods are private - as are instance - but module methods can still be called directly;


## 0.15.2 - 22nd November 2017

* improved documentation for Kernel#Integer() extension;


## 0.15.1 - 22nd November 2017

* added monkey-patched Kernel.Integer(arg, base = 0, **options);


## 0.14.1 - 15th November 2017

* added Xqsr3::HashUtilities::KeyMatching and match() and has_match?() extensions for ::Hash;


## 0.13.3 - 1st November 2017

* ParameterChecking : + now accepts type: to specify a single type (recognised when types: is not there);


## 0.13.1 - 7th August 2017

* XML compare : ~ more test cases;


## 0.12.3 - 2nd August 2017

* tidying;


## 0.12.2 - 22nd June 2017

* fixed debug-visible warnings;


## 0.12.1 - 7th June 2017

* added String.to_bool extension;


## 0.11.2 - 7th June 2017

* tagged release;


## 0.11.1 - 7th June 2017

* added ::Xqsr3::HashUtilities::DeepTransform module and + Hash.deep_transform and Hash.deep_transform! extensions; + added ::Xqsr3::StringUtilities::QuoteIf module and String.quote_if extension; + added +responds_to+ option to ::Xqsr3::Quality::ParameterChecking.check_parameter, which takes an array of messages to which the validated parameter must respond;


## 0.10.2 - 26th February 2017

* tidying;


## 0.10.1 - 26th February 2017

* ::Xqsr3::Quality::ParameterChecking::check_parameter() : + now can validate types of elements contained in array parameters;


## 0.9.2 - 26th February 2017

* minor improvement to test case;


## 0.9.1 - 26th February 2017

* adding old tag;


## 0.8.7 - 26th February 2017

* adding old tag;


## 0.8.6 - 26th February 2017

* adding old tag;


## 0.8.5 - 26th February 2017

* adding old tag;


## 0.8.4 - 26th February 2017

* adding old tag;


## 0.8.3 - 26th February 2017

* adding old tag;


## 0.8.2 - 26th February 2017

* adding old tag;


## 0.8.1 - 26th February 2017

* adding old tag;


## 0.7.2 - 26th February 2017

* adding old tag;


## 0.7.1 - 26th February 2017

* adding old tag;


## 0.6.3 - 26th February 2017

* adding old tag;


## 0.6.1 - 26th February 2017

* adding old tag;


## 0.5.2 - 26th February 2017

* adding old tag;


## 0.5.1 - 26th February 2017

* adding old tag;


## 0.4.1 - 26th February 2017

* adding old tag;


## 0.2.2 - 26th February 2017

* adding old tag;


<!-- ########################### end of file ########################### -->
