#'
#' Add contributing markdown
#'
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings.
#'
#' @returns A CONTRIBUTING.md file in the `.github` directory
#'
#' @examples
#' if (interactive()) add_contributing("katilingban/pakete")
#'
#' @export
#'
#'

add_contributing <- function(repo = NULL) {
  ## Get repo name ----
  repo_name <- stringr::str_extract(string = repo, pattern = "[^/]*$")

  ## Read template ----
  contrib_lines <- readLines(
    con = system.file("templates", "CONTRIBUTING.md", package = "pakete")
  )

  ## Replace {{repo}} ----
  contrib_lines <- contrib_lines |>
    stringr::str_replace_all(pattern = "\\{\\{repo\\}\\}", replacement = repo)

  ## Replace {{repo_name}} ----
  contrib_lines <- contrib_lines |>
    stringr::str_replace_all(
      pattern = "\\{\\{repo_name\\}\\}", replacement = repo_name
    )

  withr::with_output_sink(
    new = ".github/CONTRIBUTING.md",
    code = writeLines(text = contrib_lines, con = ".github/CONTRIBUTING.md")
  )
}
