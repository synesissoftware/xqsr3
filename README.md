# xqsr3
e**X**tensions by fine **Q**uantum for **S**tandard **R**uby and **3**rd-party libraries

[![Gem Version](https://badge.fury.io/rb/xqsr3.svg)](https://badge.fury.io/rb/xqsr3)

## Introduction

**xqsr3** is a lightweight, low-coupling library of assorted extensions to standard ruby and 3rd-party libraries.

It has **no dependencies** on any other non-standard library.

It may be pronounced (lamely) as "excusers".

## Table of Contents

1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Components](#components)
4. [Project Information](#project-information)

## Installation

Install via **gem** as in:

```
	gem install libclimate-ruby
```

or add it to your `Gemfile`.

Use is via specific APIs or groups. For example, in order to use the
``FrequencyMap`` class you would ``require`` the source file, as in:

```Ruby
require 'xqsr3/containers/frequency_map'
```

Alternatively, to use all **test/unit** extensions you would ``require`` all
relatived via the file:

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
   [**xqsr3-xml**](https://github.com/synesissoftware.com/xqsr3-xml/).

and extensions to the following standard library components:

* Array extensions
* Enumerable extensions
* Hash extensions
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

### Related projects

**xqsr3** is a runtime dependency of:

* the **[libCLImate.Ruby](https://github.com/synesissoftware/libCLImate.Ruby)** library;
* the [**xqsr3-xml**](https://github.com/synesissoftware.com/xqsr3-xml/) library.

and a development dependency of:

* the **[CLASP.Ruby](https://github.com/synesissoftware/CLASP.Ruby)** library;
* the **[cmpfs.Ruby](https://github.com/synesissoftware/cmpfs.Ruby)** library;
* the **[libpath.Ruby](https://github.com/synesissoftware/libpath.Ruby)** library;
* the **[Pantheios.Ruby](https://github.com/synesissoftware/Pantheios.Ruby)** library.
* the **[Quench.Ruby](https://github.com/synesissoftware/Quench.Ruby)** library.

### License

**xqsr3** is released under the 3-clause BSD license. See [LICENSE](./LICENSE) for details.

