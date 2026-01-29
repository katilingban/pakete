# Tests for add_github_action functions ----------------------------------------

test_that("add_github_action overwrite = FALSE works as expected", {
  skip_on_ci()
  
  dir.create(".github/workflows", recursive = TRUE)

  file.copy(
    from = system.file("actions", "netlify.yaml", package = "pakete"),
    to = ".github/workflows"
  )

  add_github_action(gha_name = "netlify")

  expect_snapshot_file(
    path = ".github/workflows/netlify.yaml",
    name = "netlify.yaml"
  )

  file.remove(".github/workflows/netlify.yaml")
  unlink(".github", recursive = TRUE)
})
