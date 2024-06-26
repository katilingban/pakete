% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_logo.R
\name{add_logo}
\alias{add_logo}
\title{Add HTML snippet for package hex sticker in README}
\usage{
add_logo(repo = NULL)
}
\arguments{
\item{repo}{Short remote git repository name. If NULL, is determined based
on current git settings.}
}
\value{
An entry to the first level header section of the README of the
repository.
}
\description{
Add HTML snippet for package hex sticker in README
}
\examples{
if (interactive()) add_logo()

}
