#'
#' Add issue templates
#'
#' @param issue A character value of type of issue template to create. Choices
#'   are *"initial-cran-release"*, *"update-cran-release"*,
#'   *"submission-cran"*, and *"acceptance-cran"*.
#' @param path Path to file to add issue template into. Set to
#'   ".github/ISSUE_TEMPLATE" which is the default location specified by
#'   GitHub.
#' @param overwrite Logical. If an existing issue template with the same file
#'   name is found, should it be overwritten? Default to FALSE.
#'
#' @returns A specified issue template markdown file in the specified `path`.
#'
#' @examples
#' if (interactive()) add_issue_template("initial-cran-release")
#'
#' @rdname add_issue
#' @export
#'

add_issue_template <- function(issue = NULL,
                               path = ".github/ISSUE_TEMPLATE",
                               overwrite = FALSE) {
  cli::cli_h1("Add issue templates")

  ## Check gha_name ----
  if (is.null(issue)) issue <- choose_issue_template(issue = issue)
  
  cli::cli_h2("Setting up project for issue templates")

  ## Create path ----
  if (!dir.exists(path)) {
    cli::cli_bullets(
      c(
        "!" = "{.file {path}} directory doesn't exist.",
        "i" = "Creating {.file {path}} directory."
      )
    )
    
    dir.create(path, recursive = TRUE)

    cli::cli_alert_success(
      "{.file {path}} directory successfully created."
    )
  }

  cli::cli_h2("Checking if {issue} template exists")

  ## Get issue template file name ----
  template_file_name <- paste0(issue, ".md")
  template_file_path <- file.path(path, template_file_name)
  
  ## Check if file already exists ----
  if (file.exists(template_file_path)) {
    cli::cli_alert_warning("{.strong {issue}} workflow already exists")
    if (!overwrite) {
      cli::cli_bullets(
        c(
          "!" = "{.code overwrite = FALSE}",
          "!" = "No changes made"
        )
      )

      FALSE
    } else {
      add_issue_template_(
        issue = issue, 
        template_file_name = template_file_name, 
        template_file_path = template_file_path, 
        overwrite = overwrite
      )
    }
  } else {
    add_issue_template_(
      issue = issue, 
      template_file_name = template_file_name, 
      template_file_path = template_file_path, 
      overwrite = overwrite
    )
  }
}

#'
#' Choose issue template
#' 
#' @keywords internal
#' 

choose_issue_template <- function(issue) {
  if (!interactive()) {
    cli::cli_abort("{.arg issue} is required.")
  }

  cli::cli_h2("Selecting issue template to add")

  prompt <- cli::format_inline(
    "Which issue template do you want to add? (0 to exit)\n"
  )

  templates <- c(
    "initial-cran-release" = "Tasks for initial CRAN release",
    "update-cran-release" = "Tasks for update CRAN releases",
    "submission-cran" = "Tasks in preparation for CRAN submission",
    "acceptance-cran" = "Tasks after acceptance to CRAN"
  )
  
  options <- paste0(cli::style_bold(names(templates)), ": ", templates)

  choice <- utils::menu(
    title = prompt,
    choices = options
  )

  if (choice == 0) {
    cli::cli_abort("Selection terminated")
  }

  names(templates)[choice]
}


#'
#' Add issue template
#' 
#' @keywords internal
#' 

add_issue_template_ <- function(issue, 
                                template_file_name, 
                                template_file_path, 
                                overwrite) {
  cli::cli_h2("Adding {issue} template")

  file.copy(
    from = system.file("templates", template_file_name, package = "pakete"),
    to = sub(paste0("/", template_file_name), "", template_file_path),
    overwrite = overwrite,
    recursive = FALSE
  )

  if (overwrite) {
    cli::cli_bullets(
      c(
        "!" = "{.code overwrite = TRUE}",
        "x" = "Overwriting existing {issue} workflow",
        "v" = "{.strong {issue}} workflow successfully updated.",
        "i" = "File: {.file {template_file_path}}"
      )
    )
  } else {
    cli::cli_bullets(
      c(
        "v" = "{.strong {issue}} workflow successfully added to project.",
        "i" = "File: {.file {template_file_path}}"
      )
    )
  }
}