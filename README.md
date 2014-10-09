# Mockasing

Extensions to Angular Mocks.

## API

### `**render**(*html*, *data*)`

Returns a rendered Angular Element, compiled from `html` and rendered with
`data`.

### `**renderElement**(*tag*, *data*, *attributes*, *transclude*)`

Utility to create `html` from the `tag`, `attributes`, and `transclude` before
rendering with `render`.

### `**renderAttribute(*directive*, *data*, *attributes*, *transclude*)`

Utility to create `html` for a `div` from  the `tag`, `attributes`, and
`transclude` before rendering with `render`.

## Changelog

* **0.0.1** *2014-10-09* Render functionality.
