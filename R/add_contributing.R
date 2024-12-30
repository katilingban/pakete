#'
#' Add contributing markdown
#'
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings.
#' @param overwrite Logical. Should an existing CONTRIBUTING.md file be
#'   overwritten? Default to FALSE.
#'
#' @returns A CONTRIBUTING.md file in the `.github` directory
#'
#' @examples
#' if (FALSE) add_contributing("katilingban/pakete")
#'
#' @export
#'
#'

add_contributing <- function(repo = NULL, overwrite = FALSE) {
  ## cli header 1 ----
  cli::cli_h1("Add CONTRIBUTING.md")

  ## Check if CONTRIBUTING.md already exists ----
  cli::cli_h2("Checking if CONTRIBUTING.md already exists")

  if (file.exists(".github/CONTRIBUTING.md")) {
    cli::cli_alert_info("{.file .github/CONTRIBUTING.md} already exists.")
    if (!overwrite) {
      cli::cli_alert_warning(
        "{.code overwrite = FALSE}; {.file .github/CONTRIBUTING.md} not updated."
      )
      FALSE
    } else {
      cli::cli_alert_danger(
        "{.code overwrite = TRUE}; {.file .github/CONTRIBUTING.md} will be overwritten."
      )
      contrib_lines <- create_contributing(repo = repo)
      save_contributing(contrib_lines)
      TRUE
    }
  } else {
    contrib_lines <- create_contributing(repo = repo)
    save_contributing(contrib_lines)
    TRUE
  }
}

#'
#' Create CONTRIBUTING.md
#' 
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings.
#'
#' @returns A CONTRIBUTING text.
#'
#' @examples
#' if (FALSE) create_contributing("katilingban/pakete")
#'
#' @keywords internal
#' 

create_contributing <- function(repo) {
  ## Create CONTRIBUTING.md ----
  cli::cli_h2("Creating CONTRIBUTING text")

  ## Get repo of repo is NULL ----
  if (is.null(repo)) repo <- get_github_repository()

  ## Get repo name ----
  repo_name <- sub(pattern = "[^/]{1,}/", replacement = "", x = repo)

  ## Read template ----
  contrib_lines <- readLines(
    con = system.file("templates", "CONTRIBUTING.md", package = "pakete")
  )

  ## Replace {{repo}} ----
  contrib_lines <- gsub(
    pattern = "\\{\\{repo\\}\\}", 
    replacement = repo, 
    x = contrib_lines
  )

  ## Replace {{repo_name}} ----
  contrib_lines <- gsub(
    pattern = "\\{\\{repo_name\\}\\}", 
    replacement = repo_name, 
    x = contrib_lines
  )

  contrib_lines

  cli::cli_alert_success("{.strong CONTRIBUTING} text created.")
}

#'
#' Save CONTRIBUTING.md
#' 
#' @param contrib_lines CONTRIBUTING text to save into CONTRIBUTING.md.
#' 
#' @returns A CONTRIBUTING.md file in the `.github` directory
#' 
#' @examples
#' if (FALSE) save_contributing(contrib_lines)
#'
#' @keywords internal 
#' 

save_contributing <- function(contrib_lines) {
  ## Save CONTRIBUTING.md ----
  cli::cli_h2("Saving CONTRIBUTING.md")

  withr::with_output_sink(
    new = ".github/CONTRIBUTING.md",
    code = writeLines(text = contrib_lines, con = ".github/CONTRIBUTING.md")
  )

  cli::cli_bullets(
    c(
      "v" = "{.strong CONTRIBUTING.md} successfully saved.",
      "i" = "File: {.file .github/CONTRIBUTING.md}"
    )
  )
}