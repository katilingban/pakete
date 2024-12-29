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

add_github_action <- function(gha_name, overwrite = FALSE) {
  ## Create path ----
  if (!dir.exists(".github/workflows")) dir.create(".github/workflows")

  ## Get GitHub Actions YAML file name ----
  gha_file_name <- paste0(gha_name, ".yaml")
  
  ## Check if file already exists ----
  if (file.exists(file.path(".github/workflows", gha_file_name)) & !overwrite) {
    message(
      gha_name, 
      " workflow already exists and `overwrite = FALSE`. No changes made."
    )
  } else {
    ## Get template ----
    yaml_template <- readLines(
      con = system.file("actions", gha_file_name, package = "pakete")
    )

    withr::with_output_sink(
      new = file.path(".github/workflows", gha_file_name),
      code = writeLines(
        text = yaml_template, 
        con = file.path(".github/workflows", gha_file_name)
      )
    )

    message(
      gha_name, 
      " workflow created at ", file.path(".github/workflows", 
      gha_file_name), "."
    )
  }  
}