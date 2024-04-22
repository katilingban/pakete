#'
#' Add issue templates
#'
#' @param issue A character value of type of issue template to create. Choices
#'   are *"initial-cran-release"*, *"update-cran-release"*,
#'   *"submission-cran"*, and *"acceptance-cran"*.
#' @param path Path to file to add issue template into. Set to
#'   ".github/ISSUE_TEMPLATE" which is the default location specified by
#'   GitHub.
#' @param overwrite Logical. If an exising issue template with the same file
#'   name is found, should it be overwritten? Default to FALSE.
#'
#' @returns A specified issue template markdown file in the specified `path`.
#'
#' @examples
#' if (interactive()) add_issue_template("initial-cran-release")
#'
#' @rdname add_issue
#' @export
#'

add_issue_template <- function(issue,
                               path = ".github/ISSUE_TEMPLATE",
                               overwrite = FALSE) {
  ## Create path ----
  if (!dir.exists(path)) dir.create(path)

  ## Get issue template file name ----
  template_file_name <- paste0(issue, ".md")

  ## Check if file already exists ----
  if (file.exists(file.path(path, template_file_name)) & !overwrite) {
    message(
      "Issue template already exists and overwrite = FALSE. No changes made."
    )
  } else {
    ## Get template ----
    issue_template <- readLines(
      con = system.file("templates", template_file_name, package = "pakete")
    )

    withr::with_output_sink(
      new = file.path(path, template_file_name),
      code = writeLines(
        text = issue_template, con = file.path(path, template_file_name)
      )
    )

    message(
      paste0(
        "Issue template created at ", file.path(path, template_file_name), ".")
    )
  }
}

