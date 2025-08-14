# Tests for add_contributing functions -----------------------------------------

test_that("add_contributing works as expected", {
  dir.create(".github")

  add_contributing(repo = "katilingban/pakete")

  expect_snapshot_file(
    path = ".github/CONTRIBUTING.md",
    name = "CONTRIBUTING.md"
  )

  file.remove(".github/CONTRIBUTING.md")
  unlink(".github", recursive = TRUE)
})


test_that("overwrite = TRUE works as expected", {
  dir.create(".github")

  file.copy(
    from = system.file("templates", "CONTRIBUTING.md", package = "pakete"),
    to = ".github"
  )

  add_contributing(repo = "katilingban/pakete", overwrite = TRUE)

  expect_snapshot_file(
    path = ".github/CONTRIBUTING.md",
    name = "CONTRIBUTING.md"
  )

  file.remove(".github/CONTRIBUTING.md")
  unlink(".github", recursive = TRUE)
})
