# Tests for add_issue_template functions ---------------------------------------

test_that("add_issue_template overwrite = FALSE works as expected", {
  skip_on_ci()
  
  dir.create(".github/ISSUE_TEMPLATE", recursive = TRUE)

  file.copy(
    from = system.file(
      "templates", "initial-cran-release.md", package = "pakete"
    ),
    to = ".github/ISSUE_TEMPLATE"
  )

  add_issue_template(issue = "initial-cran-release", overwrite = FALSE)

  expect_snapshot_file(
    path = ".github/ISSUE_TEMPLATE/initial-cran-release.md",
    name = "initial-cran-release.md"
  )

  file.remove(".github/ISSUE_TEMPLATE/initial-cran-release.md")
  unlink(".github", recursive = TRUE)
})