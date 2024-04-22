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
  ## Get repo name ----
  repo_name <- stringr::str_extract(string = repo, pattern = "[^/]*$")

  ## Check if logo is available ----
  #if (file.exists("man/figures/logo.png"))

  logo_text <- "<img src='man/figures/logo.png' width='200px' align='right' />"

  ## Determine which file to append badge to ----
  if (file.exists("README.Rmd")) {
    path <- "README.Rmd"
  } else {
    path <- "README.md"
  }

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  if (any(stringr::str_detect(string = readme_lines, pattern = logo_text)))
    return(FALSE)

  ## Get start and end line of badges ----
  header_line <- stringr::str_detect(
    readme_lines, pattern = paste0("# ", repo_name, ":")
  ) |>
    (\(x) seq_len(length(x))[x])()

  ## Create replacement text ----
  readme_lines[header_line] <- paste0(readme_lines[header_line], " ", logo_text)

  ## Append replacement text ----
  writeLines(text = readme_lines, con = path)

  ## Return TRUE if badge was added ----
  TRUE
}
