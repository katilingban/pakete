# Tests for add_github_action functions ----------------------------------------

test_that("add_github_action no directory works as expected", {
  add_github_action(gha_name = "netlify")

  expect_snapshot_file(
    path = ".github/workflows/netlify.yaml",
    name = "netlify.yaml"
  )

  file.remove(".github/workflows/netlify.yaml")
  unlink(".github", recursive = TRUE)
})
