# Tests for utility functions --------------------------------------------------

test_that("get_readme_path works as expected", {
  create_readme_file()

  rmarkdown::render("README.Rmd")
  remove_readme_file()

  expect_identical(get_readme_path(), "README.md")

  file.remove("README.md")

  expect_error(get_readme_path())
})


test_that("insert_readme_badge_text works as expected", {
  expect_error(insert_readme_badge_text())
  expect_error(
    insert_readme_badge_text(
      badge_text = "[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)"
    )
  )

  create_readme_file()
  add_badge_status("wip", path = "README.Rmd")
  readme_lines <- readLines("README.Rmd")

  expect_warning(
    insert_readme_badge_text(
      badge_text = "[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)",
      readme_lines = readme_lines
    )
  )

  remove_readme_file()
})