# xqsr3 Generated API Reference <!-- omit in toc -->

The generated API reference is produced by RDoc from the Ruby source
documentation comments. It complements the authored guides and component
catalogue:

* [`docs/components/`](../components/README.md) explains component selection
  and behaviour;
* [`docs/guides/`](../guides/README.md) explains task-oriented workflows;
* generated `doc/` explains the complete public Ruby API.


## Generate the reference

From the project root, run:

```Shell
./generate_rdoc.sh
```

The script removes any previous generated output and writes the new reference
to `doc/`. The generated files are build output and should not be edited by
hand.


## Reading the reference

Use the generated namespace and method pages for exact signatures and
source-level API details. Start with the authored documentation when deciding
which component to use, then use RDoc to inspect the complete method surface.

The RDoc index is anchored by **lib/xqsr3/doc_.rb**, which provides the
cross-component namespace overview. Public implementation comments remain the
authoritative source for signatures, options, and exceptions.


<!-- ########################### end of file ########################### -->
