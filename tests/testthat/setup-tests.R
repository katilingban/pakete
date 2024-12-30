#'
#' Create clean README.Rmd file
#' 

create_readme_file <- function() {
  readme_lines <- c(
    "---",
    "output: github_document",
    "---",
    "",
    "<!-- README.md is generated from README.Rmd. Please edit that file -->",
    "",
    "```{r, include = FALSE}",
    "knitr::opts_chunk$set(",
    "  collapse = TRUE,",
    "  comment = \"#>\",",
    "  fig.path = \"man/figures/README-\",",
    "  out.width = \"100%\"",
    ")",
    "```",
    "",
    "# pakete: Utilities for Package Development",
    "",
    "<!-- badges: start -->",
    "<!-- badges: end -->"
  )

  withr::with_output_sink(
    new = "README.Rmd",
    code = writeLines(text = readme_lines, con = "README.Rmd")
  )
}

#'
#' Remove README.Rmd file
#' 

remove_readme_file <- function() {
  file.remove("README.Rmd")
}

#'
#' Create .github/workflows directory
#' 

create_github_workflows_directory <- function() {
  dir.create(".github")
}


