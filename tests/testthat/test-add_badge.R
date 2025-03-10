# Tests for add badge functions ------------------------------------------------

skip_on_ci()

test_that("add_badge function warnings and errors work as expected", {
  expect_error(add_badge_status("moved"))
})

test_that("add_badge function works as expected", {
  create_readme_file()
  add_badge_status(path = "README.Rmd")
  add_badge_status("moved", path = "README.Rmd", .url = "https://panukatan.io")
  add_badge_codefactor(repo = "katilingban/pakete", path = "README.Rmd")
  add_badge_zenodo(repo = "katilingban/pakete", path = "README.Rmd")
  expect_snapshot_file(path = "README.Rmd", name = "README.Rmd")
  remove_readme_file()
})

