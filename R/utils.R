#
# Get current remote repository
#

get_remote_repository <- function(full = FALSE) {
  git_repo <- system("git remote -v", intern = TRUE) |>
    (\(x) x[stringr::str_detect(string = x, pattern = "push")])() |>
    stringr::str_remove_all(pattern = "origin\t| \\(push\\)")

  if (!full) {
    if (stringr::str_detect(string = git_repo, pattern = "@")) {
      git_repo <- stringr::str_extract_all(
        string = git_repo, pattern = "[^:]*$", simplify = TRUE
      ) |>
        stringr::str_remove_all(pattern = "[^.]*$|\\.") |>
        (\(x) x[1])()
    } else {
      git_repo <- stringr::str_extract_all(
        string = git_repo, pattern = "[^com]*$", simplify = TRUE
      ) |>
        stringr::str_remove_all(pattern = "[^.]*$|\\.") |>
        stringr::str_remove(pattern = "/") |>
        (\(x) x[1])()
    }
  }

  ## Return git_repo
  git_repo
}


