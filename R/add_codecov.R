#'
#' Add Codecov token snippet
#'
#' @returns An entry in the `codecov.yml` file for Codecov token specifications
#'   suitable for GitHub Actions.
#'
#' @examples
#' if (interactive()) add_codecov()
#'
#' @export
#'

add_codecov <- function() {
  if (!file.exists("codecov.yml"))
    return (FALSE)

  codecov_lines <- readLines("codecov.yml")

  if (
    any(
      stringr::str_detect(
        string = codecov_lines, pattern = "token", negate = TRUE
      )
    )
  )
    return (FALSE)


  codecov_lines <- c(
    "codecov:",
    "  token: ${{ secrets.CODECOV_TOKEN }}",
    "",
    codecov_lines
  )

  ## Append replacement text ----
  writeLines(text = codecov_lines, con = "codecov.yml")

  ## Return TRUE if snippet was added ----
  TRUE
}
