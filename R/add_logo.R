#'
#' Add HTML snippet for package hex sticker in README
#'
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings.
#'
#' @returns An entry to the first level header section of the README of the
#'   repository.
#'
#' @examples
#' if (interactive()) add_logo()
#'
#' @export
#'

add_logo <- function(repo = NULL) {
  ## cli header 1 ----
  cli::cli_h1("Add package logo")

  ## Create logo text
  cli::cli_h2("Creating package logo text")

  ## Get repo of repo is NULL ----
  if (is.null(repo)) repo <- get_github_repository()

  ## Get repo name ----
  repo_name <- sub(pattern = "[^/]{1,}/", replacement = "", x = repo)

  ## Check if logo is available ----
  logo_text <- "<img src='man/figures/logo.png' width='200px' align='right' />"

  cli::cli_bullets(
    c(
      "v" = "Logo text successfully created.",
      "i" = "Logo text: {logo_text}"
    )
  )

  cli::cli_h2("Adding logo text to README file")

  ## Determine which file to append badge to ----
  path <- get_readme_path()

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  if (any(grepl(pattern = logo_text, x = readme_lines))) {
    cli::cli_bullets(
      c(
        "!" = "Logo already exists.",
        "!" = "No changes made."
      )
    )

    FALSE
  } else {
    ## Get start and end line of badges ----
    header_line <- grep(paste0("# ", repo_name, ":"), x = readme_lines)

    ## Create replacement text ----
    readme_lines[header_line] <- paste0(
      readme_lines[header_line], " ", logo_text
    )

    ## Append replacement text ----
    writeLines(text = readme_lines, con = path)

    cli::cli_bullets(
      c(
        "v" = "Logo successfully added to README file.",
        "i" = "File: {.file {path}}" 
      )
    )

    ## Return TRUE if badge was added ----
    TRUE
  }
}
