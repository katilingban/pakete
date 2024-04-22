#'
#' Add badges to README
#'
#' @param status A character value for status to be assigned to project. This
#'   can be either *"concept"*, *"wip"*, *"suspended"*, *"abandoned"*,
#'   *"active"*, *"inactive"*, *"unsupported"*, or *"moved"*.
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings.
#' @param path Path to file to add repostatus badge to. Set to NULL by default
#'   which would indicate that a README file in the root directory of the
#'   project is the target file.
#' @param .url If `status` is "moved", the URL to which the repository has moved
#'   to. Otherwise NULL.
#'
#' @returns An entry to the badge section of the README of the repository.
#'   Otherwise, a print of the markdown text for the status badge.
#'
#' @examples
#' if (FALSE) {
#'   add_badge_status("wip")
#'   add_badge_codefactor(repo = "katilingban/pakete")
#'   add_badge_zenodo(repo = "katilingban/pakete")
#' }
#'
#' @rdname add_badge
#' @export
#'

add_badge_status <- function(status = c("concept", "wip", "suspended",
                                        "abandoned", "active", "inactive",
                                        "unsupported", "moved"),
                             path = NULL,
                             .url = NULL) {
  ## Determine status ----
  status <- match.arg(status)

  ## Determine which file to append badge to ----
  if (is.null(path)) {
    if (file.exists("README.Rmd"))
      path <- "README.Rmd"
    else
      path <- "README.md"
  }

  ## Determine what text to use based on status ----
  status_text_url <- paste0(
    "https://www.repostatus.org/badges/latest/", status, "_md.txt"
  )

  ## Read the badge text ----
  badge_text <- readLines(con = status_text_url)

  ## Replace http://example.com with .url ----
  if (!is.null(.url)) {
    badge_text <- stringr::str_replace_all(
      string = badge_text, pattern = "http://example.com", replacement = .url
    )
  }

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  if (all(badge_text %in% readme_lines))
    return(FALSE)

  ## Get start and end line of badges ----
  badges_start_line <- stringr::str_detect(
    readme_lines, pattern = "badges: start"
  ) |>
    (\(x) seq_len(length(x))[x])()

  badges_end_line <- stringr::str_detect(
    readme_lines, pattern = "badges: end"
  ) |>
    (\(x) seq_len(length(x))[x])()

  ## Create replacement text ----
  readme_lines <- c(
    readme_lines[seq_len(badges_end_line - 1)],
    badge_text,
    readme_lines[seq(from = badges_end_line, to = length(readme_lines))]
  )

  ## Append replacement text ----
  writeLines(text = readme_lines, con = path)

  ## Return TRUE if badge was added ----
  TRUE
}


#'
#' @rdname add_badge
#' @export
#'

add_badge_codefactor <- function(repo = NULL,
                                 path = NULL) {
  ## Determine repo ----
  if (is.null(repo))
    stop("Remote git repository required. Try again")

  ## Set CodeFactor defaults ----
  badge <- paste0("https://www.codefactor.io/repository/github/", repo, "/badge")
  link <- paste0("https://www.codefactor.io/repository/github/", repo)

  ## Determine which file to append badge to ----
  if (is.null(path)) {
    if (file.exists("README.Rmd"))
      path <- "README.Rmd"
    else
      path <- "README.md"
  }

  ## Create badge_text ----
  badge_text <- paste0("[![CodeFactor](", badge, ")](", link, ")")

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  if (all(badge_text %in% readme_lines))
    return(FALSE)

  ## Get start and end line of badges ----
  badges_start_line <- stringr::str_detect(
    readme_lines, pattern = "badges: start"
  ) |>
    (\(x) seq_len(length(x))[x])()

  badges_end_line <- stringr::str_detect(
    readme_lines, pattern = "badges: end"
  ) |>
    (\(x) seq_len(length(x))[x])()

  ## Create replacement text ----
  readme_lines <- c(
    readme_lines[seq_len(badges_end_line - 1)],
    badge_text,
    readme_lines[seq(from = badges_end_line, to = length(readme_lines))]
  )

  ## Append replacement text ----
  writeLines(text = readme_lines, con = path)

  ## Return TRUE if badge was added ----
  TRUE
}

#'
#' @rdname add_badge
#' @export
#'

add_zenodo_badge <- function(repo = NULL,
                             path = NULL) {
  ## Determine repo ----
  if (is.null(repo))
    stop("Remote git repository required. Try again")

  ## Get repository ID ----
  repo_id <- file.path("https://api.github.com/repos", repo) |>
    jsonlite::fromJSON() |>
    (\(x) x$id)()

  ## Set CodeFactor defaults ----
  badge <- paste0("https://zenodo.org/badge/", repo_id, ".svg")
  link <- paste0("https://zenodo.org/badge/latestdoi/", repo_id)

  ## Create badge text ----
  badge_text <- paste0("[![DOI](", badge, ")](", link, ")")

  ## Determine which file to append badge to ----
  if (is.null(path)) {
    if (file.exists("README.Rmd"))
      path <- "README.Rmd"
    else
      path <- "README.md"
  }

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  if (all(badge_text %in% readme_lines))
    return(FALSE)

  ## Get start and end line of badges ----
  badges_start_line <- stringr::str_detect(
    readme_lines, pattern = "badges: start"
  ) |>
    (\(x) seq_len(length(x))[x])()

  badges_end_line <- stringr::str_detect(
    readme_lines, pattern = "badges: end"
  ) |>
    (\(x) seq_len(length(x))[x])()

  ## Create replacement text ----
  readme_lines <- c(
    readme_lines[seq_len(badges_end_line - 1)],
    badge_text,
    readme_lines[seq(from = badges_end_line, to = length(readme_lines))]
  )

  ## Append replacement text ----
  writeLines(text = readme_lines, con = path)

  ## Return TRUE if badge was added ----
  TRUE
}
