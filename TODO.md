# xqsr3 - TODO <!-- omit in toc -->


## Functional improvements

* [x] ~~~prepare `IO.writelines` (and related helpers) for frozen-string-literal defaults (Ruby 3.4+ warnings under `-W`)~~~;
* [x] ~~~quiet Ruby 3.4 `test-unit` warnings for blocks passed to `assert_nil` / `assert_not_nil` in **test/unit/quality/tc_parameter_checking.rb**~~~;


## Performance improvements

* \<none>


## Packaging improvements

* [ ] README.md and docs/*.md introductory elements of main features;
* [ ] remove Gemfile.lock;
* [x] ~~~obtain a **run_all_unit_tests.sh** (from **misc-dev-scripts**) that skips `tput` when `$TERM` is unset or stdout is not a TTY (CI: `tput: No value for $TERM and no -T specified`)~~~;
* [x] ~~~after the packaging/boilerplate/CI baseline release: bump **VERSION**, drop gemspec `required_ruby_version` `< 4` upper bound, and align **CHANGES**~~~;
* [x] ~~~gemspec polish: `https` homepage, Rubygems `metadata` URIs, stop using `Date.today`, include **CHANGES.md** in packaged files~~~;


<!-- ########################### end of file ########################### -->
