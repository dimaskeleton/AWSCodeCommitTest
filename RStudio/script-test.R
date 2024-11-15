mul <- function(x, y){
  x * y
}

library(testthat)

test_that("Testing multiplication 1", {
  expect_equal(mul(5, 4), 20)
})

test_that("Testing multiplication 2", {
  expect_equal(mul(10, 4), 40)
})

# Test reports:
output_file <- "R-test-results.xml"
results <- test_file("RStudio/script-test.R", reporter = JunitReporter$new(file = output_file))

print("Tests completed, report generated.")
