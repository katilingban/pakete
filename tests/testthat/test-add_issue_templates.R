# Tests for add_issue_template functions ---------------------------------------

test_that("add_issue_template works as expected", {
  skip_on_ci()
  
  dir.create(".github/ISSUE_TEMPLATE", recursive = TRUE)

  expect_error(add_issue_template())

  add_issue_template(issue = "initial-cran-release")

  expect_snapshot_file(
    path = ".github/ISSUE_TEMPLATE/initial-cran-release.md",
    name = "initial-cran-release.md"
  )

  file.remove(".github/ISSUE_TEMPLATE/initial-cran-release.md")
  unlink(".github", recursive = TRUE)
})
