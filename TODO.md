# xqsr3 - TODO <!-- omit in toc -->


## Functional improvements

* [ ] prepare `IO.writelines` (and related helpers) for frozen-string-literal defaults (Ruby 3.4+ warnings under `-W`);
* [ ] quiet Ruby 3.4 `test-unit` warnings for blocks passed to `assert_nil` / `assert_not_nil` in **test/unit/quality/tc_parameter_checking.rb**;


## Performance improvements

* \<none>


## Packaging improvements

* [ ] after the packaging/boilerplate/CI baseline release: bump **VERSION**, drop gemspec `required_ruby_version` `< 4` upper bound, and align **CHANGES**;
* [ ] gemspec polish: `https` homepage, Rubygems `metadata` URIs, stop using `Date.today`, include **CHANGES.md** in packaged files;


<!-- ########################### end of file ########################### -->
