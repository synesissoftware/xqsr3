# xqsr3 Component Catalogue <!-- omit in toc -->

This catalogue is the user-oriented guide to the components provided by
**xqsr3**. It is organised by component category rather than by Ruby source
file.


## Table of Contents <!-- omit in toc -->

- [Using the catalogue](#using-the-catalogue)
- [Categories](#categories)
- [Related workflows](#related-workflows)


## Using the catalogue

Components are loaded explicitly. Each category page documents the relevant
`require` path, public entry points, and representative usage.

The catalogue documents the supported public surface. Internal files and
implementation details are intentionally excluded.

The ten category pages correspond to the public top-level component entry
points under `lib/xqsr3/`. The `Extensions` page additionally covers the
opt-in monkey patches, while `all_extensions.rb` is documented as its
broad-scope loading choice.


## Categories

* [Array Utilities](./array-utilities.md);
* [Command-line Utilities](./command-line-utilities.md);
* [Containers](./containers.md);
* [Conversion](./conversion.md);
* [Diagnostics](./diagnostics.md);
* [Extensions](./extensions.md);
* [Hash Utilities](./hash-utilities.md);
* [IO](./io.md);
* [Quality](./quality.md);
* [String Utilities](./string-utilities.md);


## Related workflows

Use the catalogue alongside the task-oriented guides:

* [Choosing a Component](../guides/choosing-a-component.md) explains how to
  select a category and loading scope;
* [Getting Started](../guides/getting-started.md) demonstrates a minimal
  application workflow;
* [Parsing and Validating External Input](../guides/parsing-and-validating-input.md)
  combines string, conversion, and quality components;
* [Processing Collections](../guides/processing-collections.md) combines
  containers, hash utilities, and extensions;
* [Handling Failures](../guides/handling-failures.md) combines quality and
  diagnostics components;
* [Formatting and Writing Output](../guides/formatting-and-writing-output.md)
  combines array, IO, and string utilities.


<!-- ########################### end of file ########################### -->
