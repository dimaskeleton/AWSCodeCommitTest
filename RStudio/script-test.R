library(testthat)

# Define the output file path for the JUnit report
output_file <- "../test-results.xml"

# Run all test files in the `tests` directory
results <- test_dir("RStudio/tests", reporter = JunitReporter$new(file = output_file))

# Print confirmation
print(paste("Tests completed, report generated at:", output_file))
