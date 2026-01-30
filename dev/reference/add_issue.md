# Add issue templates

Add issue templates

## Usage

``` r
add_issue_template(
  issue = NULL,
  path = ".github/ISSUE_TEMPLATE",
  overwrite = FALSE
)
```

## Arguments

- issue:

  A character value of type of issue template to create. Choices are
  *"initial-cran-release"*, *"update-cran-release"*,
  *"submission-cran"*, and *"acceptance-cran"*.

- path:

  Path to file to add issue template into. Set to
  ".github/ISSUE_TEMPLATE" which is the default location specified by
  GitHub.

- overwrite:

  Logical. If an existing issue template with the same file name is
  found, should it be overwritten? Default to FALSE.

## Value

A specified issue template markdown file in the specified `path`.

## Examples

``` r
if (interactive()) add_issue_template("initial-cran-release")
```
