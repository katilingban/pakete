#'
#' Add issue templates
#'
#' @param path Path to file to add issue template into. Set to
#'   ".github/ISSUE_TEMPLATE" which is the default location specified by
#'   GitHub.
#'
#' @returns A specified issue template markdown file in the specified `path`.
#'
#' @examples
#' if (interactive()) add_issue_initial_release()
#'
#' @rdname add_issue
#' @export
#'

add_issue_initial_release <- function(path = ".github/ISSUE_TEMPLATE") {
  ## Create path ----
  if (!dir.exists(path)) dir.create(path)

  ## Get template ----
  issue_template <- readLines(
    con = system.file(
      "templates", "initial-cran-release.md", package = "pakete"
    )
  )

  withr::with_output_sink(
    new = file.path(path, "initial-cran-release.md"),
    code = writeLines(
      text = issue_template, con = file.path(path, "initial-cran-release.md")
    )
  )
}

