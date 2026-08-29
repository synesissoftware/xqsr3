# xqsr3 Command-line Utilities <!-- omit in toc -->

Command-line utilities support compact mapping from user-facing option text
to stable Ruby symbols. The component is particularly useful when a command
line accepts both long option names and declared single-letter shortcuts.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [When to use it](#when-to-use-it)
- [MapOptionString](#mapoptionstring)
- [Option-string grammar](#option-string-grammar)
- [Standalone and extension forms](#standalone-and-extension-forms)
- [Failure and matching behaviour](#failure-and-matching-behaviour)


## Loading

Load the command-line utility category:

```Ruby
require 'xqsr3/command_line_utilities'
```

Or load the component directly:

```Ruby
require 'xqsr3/command_line_utilities/map_option_string'
```

The module is defined as
`Xqsr3::CommandLineUtilities::MapOptionString`.


## When to use it

Use `MapOptionString` when the application has a fixed set of option
spellings and wants the result to be a symbol suitable for dispatch:

```Ruby
options = ['help', 'version', 'verbose']
option = 'verbose'

Xqsr3::CommandLineUtilities::MapOptionString
  .map_option_string_from_string(option, options)
# => :verbose
```

It is not a complete command-line parser. It does not consume `ARGV`, parse
option arguments, or validate an option's value.


## `MapOptionString`

`map_option_string_from_string(string, option_strings)` returns the symbol
corresponding to the first matching declared option. A declared option
without shortcut syntax maps to itself:

```Ruby
require 'xqsr3/command_line_utilities/map_option_string'

mapper = Xqsr3::CommandLineUtilities::MapOptionString
declared = ['help', 'version', 'dry-run']

mapper.map_option_string_from_string('help', declared)
# => :help
mapper.map_option_string_from_string('dry-run', declared)
# => :dry_run
mapper.map_option_string_from_string('unknown', declared)
# => nil
```

The canonical option text is converted to a symbol using the String Utilities
symbol rules. Consequently, hyphens become underscores in the returned
symbol.


## Option-string grammar

Place each shortcut character in square brackets within its long spelling:

```Ruby
declared = ['[h]elp', '[v]ersion', '[d]ry-[r]un']

mapper.map_option_string_from_string('h', declared)
# => :help
mapper.map_option_string_from_string('help', declared)
# => :help
mapper.map_option_string_from_string('dr', declared)
# => :dry_run
mapper.map_option_string_from_string('dry-run', declared)
# => :dry_run
```

Every bracketed character contributes to the shortcut. Thus `[d]ry-[r]un`
declares `dr`; the unbracketed long form remains `dry-run`. Text between
brackets is retained in the long spelling and removed from the shortcut.

Shortcut matching is exact. Partial long names and individual unbracketed
characters do not match:

```Ruby
mapper.map_option_string_from_string('d', declared)
# => nil
mapper.map_option_string_from_string('dry', declared)
# => nil
```


## Standalone and extension forms

The standalone form is useful when the caller wants explicit dependencies:

```Ruby
Xqsr3::CommandLineUtilities::MapOptionString
  .map_option_string_from_string('v', ['[v]ersion'])
# => :version
```

The extension form adds `String#map_option_string`:

```Ruby
require 'xqsr3/extensions/string/map_option_string'

'v'.map_option_string(['[v]ersion'])
# => :version
```

The extension also defines `NilClass#map_option_string`, which returns `nil`.
Other receiver types must respond to `to_str`.


## Failure and matching behaviour

An unmatched input returns `nil`; no exception is raised for an ordinary
non-match. Matching is performed in declaration order, so duplicate or
overlapping declarations should be avoided.

The canonical option string is converted to a symbol only after a match.
Names containing characters that the symbol converter rejects can therefore
produce `nil` even though the option text matched.

The optional `options` argument is accepted for interface compatibility but
does not currently alter the mapping rules.

For executable behavioural examples, see
`test/unit/command_line_utilities/tc_map_option_string.rb`.


<!-- ########################### end of file ########################### -->
