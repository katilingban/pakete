# pakete: Utilities for Package Development

Tools and utilities for package development currently not available from
usual development tools. These are mostly linked to the author’s
personal preferences during the package development process. They assist
in making routine and repetitive tasks easily implementable.

## What does pakete do?

Currently, [pakete](https://katilingban.io/pakete/) includes functions
for:

1.  creating GitHub checklists for tasks in the package submission or
    package maintenance process;

2.  creating `CONTRIBUTING.md` file;

3.  adding [repostatus](https://www.repostatus.org/) badge;

4.  adding [CodeFactor](https://www.codefactor.io/) badge;

5.  adding [Zenodo](https://zenodo.org/) DOI badge; and,

6.  adding specific GitHub Actions such as test deployment of package
    website to [Netlify](https://www.netlify.com/) and mirroring of
    repository to [Codeberg](https://codeberg.org/).

## Installation

You can install [pakete](https://katilingban.io/pakete/) via the
[Katilingban R Universe](https://katilingban.r-universe.dev) as follows:

``` r
install.packages(
  "pakete",
  repos = c(
    'https://katilingban.r-universe.dev', 'https://cloud.r-project.org'
  )
)
```

## Usage

### Creating GitHub issues checklist template for CRAN submissions

It is useful for some to have a checklist of tasks to be done as part of
the CRAN submission process. The [*Releasing to
CRAN*](https://r-pkgs.org/release.html) chapter of the second edition of
the R packages book provides good templates for tasks to do for an
[initial CRAN
release](https://r-pkgs.org/release.html#sec-release-initial), an
[update CRAN
release](https://r-pkgs.org/release.html#keeping-up-with-change), a
[submission of package to
CRAN](https://r-pkgs.org/release.html#sec-release-process), and a
[post-acceptance to
CRAN](https://r-pkgs.org/release.html#sec-release-post-acceptance).

The function
[`add_issue_template()`](https://katilingban.io/pakete/dev/reference/add_issue.md)
assists in creating a GitHub issue template for your package repository
for each of these stages of preparing for, submitting to, and getting
accepted by CRAN. So, if you want to setup an issues checklist that you
can use for preparing to submit to CRAN for an initial release, use:

``` r
library(pakete)

add_issue_template("initial-cran-release")
```

This will create a markdown file called `initial-cran-release.md` inside
the `.github/ISSUE_TEMPLATE` directory (this will be created if it
doesn’t exist yet) which is where GitHub looks for issue templates to
use.

Then, once you commit and push this to your GitHub remote repository and
merge it to your `main` branch, you will now see a choice of **Initial
CRAN release** to use as a template whenever you open a new issue.

### Creating a CONTRIBUTING.md file

If you need help with getting specific language for a `CONTRIBUTING.md`
document in your repository, you may want to consider using the template
available from this package as follows:

``` r
add_contributing(repo = "YOUR_GITHUB_USERNAME/YOUR_REPO_NAME")
```

This will create a `CONTRIBUTING.md` file within the `.github` directory
(this will be created if it doesn’t exist). Do note that the
contributing process described in this markdown document is the
preferred process of those who developed the
[pakete](https://katilingban.io/pakete/) package. If you are starting
out and need something to use or something to build on, then this can
help.

### Adding a repostatus badge

If you would like to add one of the badges from
[repostatus](https://www.repostatus.org/) to signify the development
status of your project, you can do so as follows:

``` r
add_badge_status("wip")
```

This will add a status badge to your README file in the block where
badges are usually placed.

### Adding a Zenodo badge

If you use Zenodo and would like to add a [Zenodo](https://zenodo.org/)
badge to your README (even if you haven’t made a release for your
repository/project, a pre-allocation of DOI is made), you can use the
[`add_badge_zenodo()`](https://katilingban.io/pakete/dev/reference/add_badge.md)
function as follows:

``` r
add_badge_zenodo(repo = "YOUR_GITHUB_USERNAME/YOUR_REPO_NAME")
```

This will add a Zenodo badge to your README file in the block were
badges are usually placed. Please note that whilst this can be used to
add a Zenodo badge even if you haven’t made a GitHub release yet, the
actual badge will only appear and the DOI assigned to your repository
will only be issued once you have made your first GitHub release. Hence,
you should only do this either as a post-acceptance to CRAN step when
you will make your first GitHub release after your CRAN release or as
part of a GitHub pre-release to activate a DOI for your repository. It
would not be advisable to add this badge to your README without a GitHub
release before you submit to CRAN as you will have check errors in
relation to the Zenodo release URL.

## Citation

If you find the [pakete](https://katilingban.io/pakete/) package useful
please cite using the suggested citation provided by a call to the
[`citation()`](https://rdrr.io/r/utils/citation.html) function as
follows:

``` r
citation("pakete")
#> To cite pakete in publications use:
#> 
#>   Ernest Guevarra (2024). _pakete: Utilities for Package Development_.
#>   doi:10.5281/zenodo.11040826
#>   <https://doi.org/10.5281/zenodo.11040826>, R package version 0.2.0,
#>   <https://katilingban.io/pakete/>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {pakete: Utilities for Package Development},
#>     author = {{Ernest Guevarra}},
#>     year = {2024},
#>     note = {R package version 0.2.0},
#>     url = {https://katilingban.io/pakete/},
#>     doi = {10.5281/zenodo.11040826},
#>   }
```

## Community guidelines

Feedback, bug reports and feature requests are welcome; file issues or
seek support [here](https://github.com/katilingban/pakete/issues). If
you would like to contribute to the package, please see our
[contributing
guidelines](https://katilingban.io/pakete/CONTRIBUTING.html).

Please note that the [pakete](https://katilingban.io/pakete/) project is
released with a [Contributor Code of
Conduct](https://katilingban.io/pakete/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
