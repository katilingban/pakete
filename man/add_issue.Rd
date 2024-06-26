% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_issue_templates.R
\name{add_issue_template}
\alias{add_issue_template}
\title{Add issue templates}
\usage{
add_issue_template(issue, path = ".github/ISSUE_TEMPLATE", overwrite = FALSE)
}
\arguments{
\item{issue}{A character value of type of issue template to create. Choices
are \emph{"initial-cran-release"}, \emph{"update-cran-release"},
\emph{"submission-cran"}, and \emph{"acceptance-cran"}.}

\item{path}{Path to file to add issue template into. Set to
".github/ISSUE_TEMPLATE" which is the default location specified by
GitHub.}

\item{overwrite}{Logical. If an existing issue template with the same file
name is found, should it be overwritten? Default to FALSE.}
}
\value{
A specified issue template markdown file in the specified \code{path}.
}
\description{
Add issue templates
}
\examples{
if (interactive()) add_issue_template("initial-cran-release")

}
