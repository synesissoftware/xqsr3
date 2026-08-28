# xqsr3 Quality <!-- omit in toc -->

Quality components support explicit validation of method parameters and
preconditions.


## Table of Contents <!-- omit in toc -->

- [Loading](#loading)
- [Components](#components)


## Loading

```Ruby
require 'xqsr3/quality'
```


## Components

### `Quality::ParameterChecking`

Provides reusable checks for validating parameter values, types, and
relationships.

```Ruby
require 'xqsr3/quality/parameter_checking'
```

Use the checks at public method boundaries so invalid arguments fail close to
their source.


<!-- ########################### end of file ########################### -->
