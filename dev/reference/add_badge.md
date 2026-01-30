# Add badges to README

Add badges to README

## Usage

``` r
add_badge_status(
  status = c("concept", "wip", "suspended", "abandoned", "active", "inactive",
    "unsupported", "moved"),
  path = NULL,
  .url = NULL
)

add_badge_codefactor(repo = NULL, path = NULL)

add_badge_zenodo(repo = NULL, path = NULL)
```

## Arguments

- status:

  A character value for status to be assigned to project. This can be
  either *"concept"*, *"wip"*, *"suspended"*, *"abandoned"*, *"active"*,
  *"inactive"*, *"unsupported"*, or *"moved"*.

- path:

  Path to file to add repostatus badge to. Set to NULL by default which
  would indicate that a README file in the root directory of the project
  is the target file.

- .url:

  If `status` is "moved", the URL to which the repository has moved to.
  Otherwise NULL.

- repo:

  Short remote git repository name. If NULL, is determined based on
  current git settings.

## Value

An entry to the badge section of the README of the repository.
Otherwise, a print of the markdown text for the status badge.

## Examples

``` r
if (FALSE) {
  add_badge_status("wip")
  add_badge_codefactor(repo = "katilingban/pakete")
  add_badge_zenodo(repo = "katilingban/pakete")
}
```
