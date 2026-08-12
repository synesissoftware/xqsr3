# xqsr3 <!-- omit in toc -->

e**X**tensions by fine **Q**uantum for **S**tandard **R**uby and **3**rd-party libraries

![Language](https://img.shields.io/badge/Ruby-CC342D?style=flat&logo=ruby&logoColor=white)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Gem Version](https://badge.fury.io/rb/xqsr3.svg)](https://badge.fury.io/rb/xqsr3)
[![Last Commit](https://img.shields.io/github/last-commit/synesissoftware/xqsr3)](https://github.com/synesissoftware/xqsr3/commits/master)
[![Ruby](https://github.com/synesissoftware/xqsr3/actions/workflows/ruby.yml/badge.svg)](https://github.com/synesissoftware/xqsr3/actions/workflows/ruby.yml)


## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
- [Installation](#installation)
- [Components](#components)
- [Examples](#examples)
- [Project Information](#project-information)
  - [Where to get help](#where-to-get-help)
  - [Contribution guidelines](#contribution-guidelines)
  - [Dependencies](#dependencies)
    - [Efferent (fan-out)](#efferent-fan-out)
      - [Runtime Dependencies (aka "Normal Dependencies")](#runtime-dependencies-aka-normal-dependencies)
      - [Development Dependencies](#development-dependencies)
    - [Afferent (fan-in)](#afferent-fan-in)
      - [Runtime dependents](#runtime-dependents)
      - [Development dependents](#development-dependents)
  - [Related projects](#related-projects)
  - [License](#license)


## Introduction

**xqsr3** is a lightweight, low-coupling library of assorted extensions to standard ruby and 3rd-party libraries. It has zero runtime dependencies.

It has **no dependencies** on any other non-standard library.

It may be pronounced (lamely) as "excusers".


## Installation

Install via **gem** as in:

```
gem install xqsr3
```

or add it to your `Gemfile`.

Use is via specific APIs or groups. For example, in order to use the
``FrequencyMap`` class you would ``require`` the source file, as in:

```Ruby
require 'xqsr3/containers/frequency_map'
```

Alternatively, to use all **test/unit** extensions you would ``require`` all
relative via the file:

```Ruby
require 'xqsr3/extensions/test/unit'
```

which brings in nine extensions.


## Components

**xqsr3** provides components in the following categories:

* Array Utilities
* Command-line Utilities
* Containers
* Conversion
* Diagnostics
* Hash Utilities
* IO
* Quality
* String Utilities
* ~~XML Utilities~~ **NOTE**: The **XML** components formerly in **xqsr3** in
   versions **0.29**-**0.30** are now contained in the separate project
   [**xqsr3-xml**](https://github.com/synesissoftware/xqsr3-xml/).

and extensions to the following standard library components:

* Array extensions
* Enumerable extensions
* Hash extensions
* Integer extensions
* IO extensions
* Kernel extensions
* String extensions
* test/unit extensions


## Examples

Examples are provided in the ```examples``` directory, along with a markdown description for each. A detailed list TOC of them is provided in [EXAMPLES.md](./EXAMPLES.md).


## Project Information


### Where to get help

[GitHub Page](https://github.com/synesissoftware/xqsr3 "GitHub Page")


### Contribution guidelines

Defect reports, feature requests, and pull requests are welcome on https://github.com/synesissoftware/xqsr3.


### Dependencies


#### Efferent (fan-out)

Libraries upon which **xqsr3** depends:


##### Runtime Dependencies (aka "Normal Dependencies")

* \<none>;


##### Development Dependencies

* [**rake**](https://rubygems.org/gems/rake);
* [**test-unit**](https://rubygems.org/gems/test-unit);


#### Afferent (fan-in)

Projects that depend on **xqsr3**:


##### Runtime dependents

* [**comment_strip-ruby**](https://github.com/synesissoftware/comment_strip.r);
* [**libCLImate.Ruby**](https://github.com/synesissoftware/libCLImate.Ruby);
* [**xqsr3-xml**](https://github.com/synesissoftware/xqsr3-xml/);


##### Development dependents

* [**CLASP.Ruby**](https://github.com/synesissoftware/CLASP.Ruby);
* [**cmpfs.Ruby**](https://github.com/synesissoftware/cmpfs.Ruby);
* [**Diagnosticism.Ruby**](https://github.com/synesissoftware/Diagnosticism.Ruby);
* [**libpath.Ruby**](https://github.com/synesissoftware/libpath.Ruby);
* [**Pantheios.Ruby**](https://github.com/synesissoftware/Pantheios.Ruby);
* [**Quench.Ruby**](https://github.com/synesissoftware/Quench.Ruby);
* [**recls.Ruby**](https://github.com/synesissoftware/recls.Ruby);


### Related projects

* [**xqsr3-xml**](https://github.com/synesissoftware/xqsr3-xml/) — XML components formerly shipped in **xqsr3**;


### License

**xqsr3** is released under the 3-clause BSD license. See [LICENSE](./LICENSE) for details.


<!-- ########################### end of file ########################### -->
