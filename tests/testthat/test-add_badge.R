# Tests for add badge functions ------------------------------------------------

test_that("add_badge function warnings and errors work as expected", {
  expect_error(add_badge_status("moved"))
})
