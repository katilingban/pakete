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
  ## cli header 1 ----
  cli::cli_h1("Add repostatus badge")
  
  ## Determine status ----
  status <- match.arg(status)

  cli::cli_h2("Creating {status} repostatus badge")

  ## Determine what text to use based on status ----
  status_text_url <- paste0(
    "https://www.repostatus.org/badges/latest/", status, "_md.txt"
  )

  ## Read the badge text ----
  badge_text <- readLines(con = status_text_url)

  ## If status is moved ----
  if (status == "moved") {
    ## Check if .url is provided ----
    if (is.null(.url)) {
      cli::cli_abort(
        c(
          '{.var .url} cannot be NULL when {.var status} is "moved"',
          "x" = '{.var .url} is NULL and {.var status} is "moved"'
        )
      )
    } else {
      ## Replace https://example.com ----
      badge_text <- gsub(
        pattern = "http://example.com", replacement = .url, x = badge_text
      )
    }
  }

  cli::cli_bullets(
    c(
      "v" = "{status} repostatus badge created",
      "i" = "Badge: {badge_text}"
    )
  )

  cli::cli_h2("Adding {status} repostatus badge to README file")

  ## Determine which file to append badge to ----
  path <- get_readme_path(path = path)

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  ## Insert badge text to README ----
  insert_readme_badge_text(
    badge_text = badge_text, readme_lines = readme_lines, path = path
  )
}


#'
#' @rdname add_badge
#' @export
#'

add_badge_codefactor <- function(repo = NULL,
                                 path = NULL) {
  cli::cli_h1("Add CodeFactor badge")

  cli::cli_h2("Creating CodeFactor badge")

  ## Get repo ----
  if (is.null(repo)) repo <- get_github_repository()
  
  ## Set CodeFactor defaults ----
  badge <- paste0("https://www.codefactor.io/repository/github/", repo, "/badge")
  link <- paste0("https://www.codefactor.io/repository/github/", repo)

  ## Create badge_text ----
  badge_text <- paste0("[![CodeFactor](", badge, ")](", link, ")")

  cli::cli_bullets(
    c(
      "v" = "CodeFactor badge successfully created.",
      "i" = "Badge: {badge_text}"
    )
  )

  cli::cli_h2("Adding CodeFactor badge to README")

  ## Determine which file to append badge to ----
  path <- get_readme_path(path = path)

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  ## Insert badge text to README ----
  insert_readme_badge_text(
    badge_text = badge_text, readme_lines = readme_lines, path = path
  )
}

#'
#' @rdname add_badge
#' @export
#'

add_badge_zenodo <- function(repo = NULL,
                             path = NULL) {
  cli::cli_h1("Add Zenodo badge")

  cli::cli_h2("Creating Zenodo badge")

  if (is.null(repo)) repo <- get_github_repository()

  ## Get repository ID ----
  repo_id <- get_github_repository_id(repo = repo)

  ## Set CodeFactor defaults ----
  badge <- paste0("https://zenodo.org/badge/", repo_id, ".svg")
  link <- paste0("https://zenodo.org/badge/latestdoi/", repo_id)

  ## Create badge text ----
  badge_text <- paste0("[![DOI](", badge, ")](", link, ")")

  cli::cli_bullets(
    c(
      "v" = "Zenodo badge successfully created.",
      "i" = "Badge: {badge_text}"
    )
  )

  cli::cli_h2("Adding Zenodo badge to README")

  ## Determine which file to append badge to ----
  path <- get_readme_path(path = path)

  ## Read file in path ----
  readme_lines <- readLines(path, encoding = "UTF-8")

  ## Insert badge text to README ----
  insert_readme_badge_text(
    badge_text = badge_text, readme_lines = readme_lines, path = path
  )
}
