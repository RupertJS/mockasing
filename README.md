# Mockasing

Extensions to Angular Mocks.

## API

### **render**(*html*, *data*, *parent*)

Returns a rendered Angular Element, compiled from `html`, rendered with
`data`, and appended to `parent`.

### **renderElement**(*tag*, *data*, *attributes*, *transclude*, *parent*)

Utility to create `html` from the `tag`, `attributes`, and `transclude` before
rendering with `render`. If `parent` is present and is an `angular.element`, the
template will be appended as a child. Useful for testing directives like
`ng-repeat`, where otherwise the returned element would be just the first
comment in the rendered repeater.

## Changelog

* **0.0.2** *2014-10-09* Publishing Snafu.
* **0.0.1** *2014-10-09* Render functionality.
