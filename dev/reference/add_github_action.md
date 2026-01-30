# Add GitHub Actions

Add GitHub Actions

## Usage

``` r
add_github_action(gha_name = NULL, repo = NULL, overwrite = FALSE)
```

## Arguments

- gha_name:

  Short name of GitHub Action to add. Currently supports GitHub Action
  for Netlify deployment of testing version of pkgdown website
  (*"netlify"*), GitHub Action for mirroring to Codeberg
  (*"mirror-codeberg"*), and GitHub Action for R-universe testing
  (*"r-universe-test"*).

- repo:

  Short remote git repository name. If NULL, is determined based on
  current git settings. Evaluated only if `gha_name` is
  *"mirror-codeberg"*.

- overwrite:

  Logical. Should an existing GitHub Action be overwritten? Default is
  FALSE.

## Value

A GitHub Action YAML file of the specified workflow to be added in
`.github/workflows` directory.

## Examples

``` r
if (FALSE) add_github_action(gha_name = "netlify")
```
