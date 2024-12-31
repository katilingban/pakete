# Tests for add_issue_template functions ---------------------------------------

test_that("add_issue_template works as expected", {
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


test_that("add_issue_template no directory works as expected", {
  add_issue_template(issue = "initial-cran-release")

  expect_snapshot_file(
    path = ".github/ISSUE_TEMPLATE/initial-cran-release.md",
    name = "initial-cran-release.md"
  )

  file.remove(".github/ISSUE_TEMPLATE/initial-cran-release.md")
  unlink(".github", recursive = TRUE)
})


test_that("add_issue_template overwrite = TRUE works as expected", {
  dir.create(".github/ISSUE_TEMPLATE", recursive = TRUE)

  file.copy(
    from = system.file(
      "templates", "initial-cran-release.md", package = "pakete"
    ),
    to = ".github/ISSUE_TEMPLATE"
  )

  add_issue_template(issue = "initial-cran-release", overwrite = TRUE)

  expect_snapshot_file(
    path = ".github/ISSUE_TEMPLATE/initial-cran-release.md",
    name = "initial-cran-release.md"
  )

  file.remove(".github/ISSUE_TEMPLATE/initial-cran-release.md")
  unlink(".github", recursive = TRUE)
})


test_that("add_issue_template overwrite = FALSE works as expected", {
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