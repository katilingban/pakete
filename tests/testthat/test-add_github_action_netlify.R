# Tests for add_github_action functions ----------------------------------------

test_that("add_github_action works as expected", {
  dir.create(".github/workflows", recursive = TRUE)

  expect_error(add_github_action())

  add_github_action(gha_name = "netlify")

  expect_snapshot_file(
    path = ".github/workflows/netlify.yaml",
    name = "netlify.yaml"
  )

  file.remove(".github/workflows/netlify.yaml")
  unlink(".github", recursive = TRUE)
})
