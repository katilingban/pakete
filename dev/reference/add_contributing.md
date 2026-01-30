# Add contributing markdown

Add contributing markdown

## Usage

``` r
add_contributing(repo = NULL, overwrite = FALSE)
```

## Arguments

- repo:

  Short remote git repository name. If NULL, is determined based on
  current git settings.

- overwrite:

  Logical. Should an existing CONTRIBUTING.md file be overwritten?
  Default to FALSE.

## Value

A CONTRIBUTING.md file in the `.github` directory

## Examples

``` r
if (FALSE) add_contributing("katilingban/pakete")
```
