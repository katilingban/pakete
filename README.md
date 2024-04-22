
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pakete: Utilities for Package Development <img src='man/figures/logo.png' width='200px' align='right' />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/katilingban/pakete/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/katilingban/pakete/actions/workflows/R-CMD-check.yaml)
[![CodeFactor](https://www.codefactor.io/repository/github/katilingban/pakete/badge)](https://www.codefactor.io/repository/github/katilingban/pakete)
[![DOI](https://zenodo.org/badge/790010725.svg)](https://zenodo.org/badge/latestdoi/790010725)
<!-- badges: end -->

Tools and utilities for package development currently not available from
usual development tools. These are mostly linked to personal preferences
during the development process. They assist in making routine and
repetitive tasks easily implementable.

## What does `pakete` do?

Currently, `pakete` includes functions for:

1.  creating GitHub checklists for tasks in the package submission
    process;

2.  creating `_pkgdown.yml` templates for projects that I work on;

3.  creating `CONTRIBUTING.md` file;

4.  adding `repostatus` badge; and,

5.  adding Zenodo DOI badge.

## Installation

You can install `pakete` via the [Katilingban
R-universe](https://katilingban.r-universe.dev) as follows:

``` r
install.packages(
  "pakete",
  repos = c('https://katilingban.r-universe.dev', 'https://cloud.r-project.org')
)
```

## Usage

## Citation

If you find the `pakete` package useful please cite using the suggested
citation provided by a call to the `citation()` function as follows:

``` r
citation("pakete")
#> To cite pakete in publications use:
#> 
#>   Ernest Guevarra (2024). _pakete: Utilities for Package Development_.
#>   R package version 0.0.9000, <https://katilingban.io/pakete/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {pakete: Utilities for Package Development},
#>     author = {{Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.0.9000},
#>     url = {https://katilingban.io/pakete/},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/katilingban/pakete/issues). If
you would like to contribute to the package, please see our
[contributing
guidelines](https://katilingban.io/pakete/CONTRIBUTING.html).

Please note that the `paketa` project is released with a [Contributor
Code of Conduct](https://katilingban.io/pakete/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
