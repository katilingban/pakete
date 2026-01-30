# Add HTML snippet for package hex sticker in README

Add HTML snippet for package hex sticker in README

## Usage

``` r
add_logo(repo = NULL)
```

## Arguments

- repo:

  Short remote git repository name. If NULL, is determined based on
  current git settings.

## Value

An entry to the first level header section of the README of the
repository.

## Examples

``` r
if (interactive()) add_logo()
```
