#'
#' Get current remote GitHub repository
#' 
#' @param full Logical. Should full GitHub remote URL be extracted? Default to
#'   FA:SE.
#' 
#' @returns GitHub remote repository.
#' 
#' @examples
#' if (FALSE) get_github_repository()
#' 
#' @keywords internal
#' 

get_github_repository <- function(full = FALSE) {
  ## Check if current directory is a git directory ----
  git_status <- system("git -C . rev-parse 2>/dev/null; echo $?", intern = TRUE)

  ## Check if git directory ----
  if (git_status != 0) {
    cli::cli_abort(
      c(
        "Current working directory should be a git repository",
        "x" = "Current working directory is not a git repository"
      )
    )
  } else {
    git_repo <- system("git remote -v", intern = TRUE) |>
      grep(pattern = "push", x = _, value = TRUE) |>
      gsub(pattern = "origin\t| \\(push\\)", replacement = "", x = _)
  
    if (!full) {
      if (grepl(pattern = "@", x = git_repo)) {
        git_repo <- gsub(
          pattern = "git@github.com:|.git", replacement = "", x = git_repo
        )
      } else {
        git_repo <- gsub(
          pattern = "https://github.com/|.git", replacement = "", x = git_repo
        )
      }
    }
  }

  ## Return git_repo
  git_repo
}


#'
#' Get GitHub repository ID
#' 
#' @param repo Short remote git repository name for current project.
#' 
#' @returns An integer value for the GitHub repository ID.
#' 
#' @examples
#' if (FALSE) get_gihtub_repository_id(repo = "katilingban/pakete")
#' 
#' @keywords internal
#' 
#' 

get_github_repository_id <- function(repo) {
  ## Get repository ID ----
  file.path("https://api.github.com/repos", repo) |>
    jsonlite::fromJSON() |>
    (\(x) x$id)()
}

#'
#' Get file path to README file
#' 
#' @param path Path to README file. Set to NULL by default which would indicate 
#'   that a README file is in the root directory of the project.
#' 
#' @returns Path to README file.
#' 
#' @examples
#' if (FALSE) get_readme_path()
#' 
#' @keywords internal
#' 
#' 

get_readme_path <- function(path = NULL) {
  ## Determine which file to append badge to ----
  if (is.null(path)) {
    if (file.exists("README.Rmd"))
      path <- "README.Rmd"
    else
      if (file.exists("README.md"))
        path <- "README.md"
      else
        cli::cli_abort(
          c(
            "A README file is needed",
            "x" = "The project has no README file."
          )
        )
  }

  ## Return path to README file ----
  path
}


#'
#' Insert text to badge section of README lines
#' 
#' @param badge_text A character value for text to insert into badge section of
#'   README lines.
#' @param readme_lines A character vector of lines of text in README.
#' @param path Path to file to add repostatus badge to.
#' 
#' @returns A character vector of README lines of text.
#' 
#' @examples
#' if (FALSE) get_readme_badge_lines(readme_lines)
#' 
#' @keywords internal
#' 

insert_readme_badge_text <- function(badge_text = NULL, 
                                     readme_lines = NULL,
                                     path) {
  ## Check if badge_text is missing ----
  if (is.null(badge_text))
    cli::cli_abort(
      c(
        "Badge text to insert to README is required.",
        "x" = "Badge text is missing."
      )
    )
  
  ## Check if readme_lines is missing ----
  if (is.null(readme_lines))
    cli::cli_abort(
      c(
        "README text to update is required.",
        "x" = "README text is missing."
      )
    )
  
  ## Insert badge text ----
  if (badge_text %in% readme_lines) {
    ## Warning that status badge not added ----
    cli::cli_warn(
      c(
        "!" = "Status badge already exists",
        "i" = "Status badge not added."
      )
    )

    FALSE
  } else {
    ## Get start and end line of badges ----
    badges_start_line <- grep(pattern = "badges: start", x = readme_lines)
    badges_end_line <- grep(pattern = "badges: end", x = readme_lines)

    ## Create replacement text ----
    readme_lines <- c(
      readme_lines[seq_len(badges_end_line - 1)],
      badge_text,
      readme_lines[seq(from = badges_end_line, to = length(readme_lines))]
    )

    ## Append replacement text ----
    writeLines(text = readme_lines, con = path)

    ## Success message that status badge has been added ----
    cli::cli_bullets(
      c(
        "v" = "{.strong {status}} repostatus badge successfully added to README",
        "i" = "README file: {.file {path}}"
      )
    )

    ## Return TRUE if badge was added ----
    TRUE    
  }
}
