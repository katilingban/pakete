#'
#' Add GitHub Actions
#' 
#' @param gha_name Short name of GitHub Action to add. Currently supports
#'   GitHub Action for Netlify deployment of testing version of pkgdown website
#'   (*"netlify"*).
#' @param overwrite Logical. Should an existing GitHub Action be overwritten?
#'   Default is FALSE.
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

add_github_action <- function(gha_name = NULL, overwrite = FALSE) {
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
    
    dir.create(".github/workflows")

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
        gha_name, gha_file_name, gha_file_path, overwrite = overwrite
      )
    }
  } else {
    add_gha_workflow(
      gha_name, gha_file_name, gha_file_path, overwrite = overwrite
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
    "netlify" = "Preview pkgdown website on pull request via Netlify"
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
                             overwrite) {
  cli::cli_h2("Adding {gha_name} workflow")

  file.copy(
    from = system.file("actions", gha_file_name, package = "pakete"),
    to = ".github/workflows",
    overwrite = overwrite,
    recursive = FALSE
  )

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
