#'
#' Add GitHub Actions
#' 
#' @param gha_name Short name of GitHub Action to add. Currently supports
#'   GitHub Action for Netlify deployment of testing version of pkgdown website
#'   (*"netlify"*), GitHub Action for mirroring to Codeberg
#'   (*"mirror-codeberg"*), and GitHub Action for R-universe testing
#'   (*"r-universe-test"*).
#' @param overwrite Logical. Should an existing GitHub Action be overwritten?
#'   Default is FALSE.
#' @param repo Short remote git repository name. If NULL, is determined based
#'   on current git settings. Evaluated only if `gha_name` is
#'   *"mirror-codeberg"*.
#' 
#' @returns A GitHub Action YAML file of the specified workflow to be added in
#'   `.github/workflows` directory.
#' 
#' @examples
#' if (FALSE) add_github_action(gha_name = "netlify")
#' 
#' @export
#' @rdname add_github_action
#' 

add_github_action <- function(gha_name = NULL, repo = NULL, overwrite = FALSE) {
  cli::cli_h1("Add GitHub Actions workflow")

  ## Check gha_name ----
  if (is.null(gha_name)) gha_name <- choose_gha_workflow(gha_name = gha_name)

  cli::cli_h2("Setting up project for GitHub Actions")

  ## Create path ----
  if (!dir.exists(".github/workflows")) {
    cli::cli_bullets(
      c(
        "!" = "{.file .github/workflows} directory doesn't exist.",
        "i" = "Creating {.file .github/workflows} directory."
      )
    )
    
    dir.create(".github/workflows", recursive = TRUE)

    cli::cli_alert_success(
      "{.file .github/workflows} directory successfully created."
    )
  }

  cli::cli_h2("Checking if {gha_name} workflow exists")

  ## Get GitHub Actions YAML file name ----
  gha_file_name <- paste0(gha_name, ".yaml")
  gha_file_path <- file.path(".github/workflows", gha_file_name)

  ## Check if file already exists ----
  if (file.exists(gha_file_path)) {
    cli::cli_alert_warning("{.strong {gha_name}} workflow already exists")
    if (!overwrite) {
      cli::cli_bullets(
        c(
          "!" = "{.code overwrite = FALSE}",
          "!" = "No changes made"
        )
      )

      FALSE
    } else {
      add_gha_workflow(
        gha_name, gha_file_name, gha_file_path, 
        repo = repo, overwrite = overwrite
      )
    }
  } else {
    add_gha_workflow(
      gha_name, gha_file_name, gha_file_path, 
      repo = repo, overwrite = overwrite
    )
  }  
}

#'
#' Choose GHA workflow
#' 
#' @keywords internal
#' 

choose_gha_workflow <- function(gha_name) {
  if (!interactive()) {
    cli::cli_abort("{.arg gha_name} is required.")
  }

  cli::cli_h2("Selecting GitHub Actions to add")

  prompt <- cli::format_inline("Which action do you want to add? (0 to exit)\n")

  workflows <- c(
    "netlify" = "Preview pkgdown website on pull request via Netlify",
    "mirror-codeberg" = "Mirror repository to Codeberg",
    "r-universe-test" = "Test R-universe"
  )
  
  options <- paste0(cli::style_bold(names(workflows)), ": ", workflows)

  choice <- utils::menu(
    title = prompt,
    choices = options
  )

  if (choice == 0) {
    cli::cli_abort("Selection terminated")
  }

  names(workflows)[choice]
}


#'
#' Add GHA workflow
#' 
#' @keywords internal
#' 

add_gha_workflow <- function(gha_name, 
                             gha_file_name, 
                             gha_file_path,
                             repo = NULL, 
                             overwrite) {
  cli::cli_h2("Adding {gha_name} workflow")

  ## Mirror Codeberg workflow ----
  if (gha_name == "mirror-codeberg") {
    gha_text <- create_gha_workflow_codeberg_mirror(repo = repo)
    save_gha_workflow_codeberg_mirror(gha_text = gha_text)
  } else {
    file.copy(
      from = system.file("actions", gha_file_name, package = "pakete"),
      to = ".github/workflows",
      overwrite = overwrite,
      recursive = FALSE
    )
  }
  
  if (overwrite) {
    cli::cli_bullets(
      c(
        "!" = "{.code overwrite = TRUE}",
        "x" = "Overwriting existing {gha_name} workflow",
        "v" = "{.strong {gha_name}} workflow successfully updated.",
        "i" = "File: {.file {gha_file_path}}"
      )
    )
  } else {
    cli::cli_bullets(
      c(
        "v" = "{.strong {gha_name}} workflow successfully added to project.",
        "i" = "File: {.file {gha_file_path}}"
      )
    )
  }
}

#'
#' @keywords internal
#' 

create_gha_workflow_codeberg_mirror <- function(repo = NULL) {
  ## Create Codeberg mirror GHA workflow ----
  cli::cli_h2("Creating Codeberg mirror GitHub Actions workflow text")

  ## Get repo of repo is NULL ----
  if (is.null(repo)) repo <- get_github_repository()

  ## Create codeberg git url ----
  codeberg_remote <- file.path("https://codeberg.org", repo)

  gha_text <- readLines(
    con = system.file("actions", "mirror-codeberg.yaml", package = "pakete")
  )

  gha_text <- gha_text |>
    sub(pattern = "CODEBERG_REMOTE", replacement = codeberg_remote, x = _)

  cli::cli_alert_success("{.strong Codeberg mirror GitHub Actions} text created.")
  gha_text
}


#'
#' Save Codeberg mirror GitHub Actions workflow
#' 
#' @param gha_text Codeberg mirror GitHub Actions workflow text to save into
#'   mirror-codeberg.yaml.
#' 
#' @returns A mirror-codeberg.yaml file in the `.github/workflows` directory
#' 
#' @examples
#' if (FALSE) save_gha_workflow_codeberg_mirror(gha_text)
#'
#' @keywords internal 
#' 

save_gha_workflow_codeberg_mirror <- function(gha_text) {
  ## Save mirror-codeberg.yaml ----
  cli::cli_h2("Saving mirror-codeberg.yaml")

  withr::with_output_sink(
    new = ".github/workflows/mirror-codeberg.yaml",
    code = writeLines(
      text = gha_text, con = ".github/workflows/mirror-codeberg.yaml"
    )
  )

  cli::cli_bullets(
    c(
      "v" = "{.strong mirror-codeberg.yaml} successfully saved.",
      "i" = "File: {.file .github/working/mirror-codeberg.yaml}"
    )
  )
}
