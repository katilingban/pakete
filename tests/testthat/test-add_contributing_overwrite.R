# Tests for add_contributing functions -----------------------------------------

test_that("overwrite = TRUE works as expected", {
  skip_on_ci()

  dir.create(".github")

  file.copy(
    from = system.file("templates", "CONTRIBUTING.md", package = "pakete"),
    to = ".github"
  )

  add_contributing(repo = "katilingban/pakete", overwrite = TRUE)

  expect_snapshot_file(
    path = ".github/CONTRIBUTING.md"#,
    #name = "CONTRIBUTING.md"
  )

  file.remove(".github/CONTRIBUTING.md")
  unlink(".github", recursive = TRUE)
})
