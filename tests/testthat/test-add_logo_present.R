# Tests for add_logo functions -------------------------------------------------

test_that("add_logo with logo present works as expected", {
  create_readme_file()

  add_logo(repo = "katilingban/pakete")

  add_logo(repo = "katilingban/pakete")

  expect_snapshot_file(
    path = "README.Rmd",
    name = "README.Rmd"
  )

  remove_readme_file()
})
