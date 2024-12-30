# Tests for add_contributing functions -----------------------------------------

test_that("add_contributing works as expected", {
  expect_type(create_contributing(repo = "katilingban/pakete"), "character")

  dir.create(".github")

  add_contributing(repo = "katilingban/pakete")

  expect_snapshot_file(
    path = ".github/CONTRIBUTING.md",
    name = "CONTRIBUTING.md"
  )

  file.remove(".github/CONTRIBUTING.md")
  unlink(".github", recursive = TRUE)
})
