library(testthat)

args <- commandArgs(trailingOnly = FALSE)
script_path <- dirname(normalizePath(sub("--file=", "", args[grep("--file=", args)])))

setwd(script_path)

print(paste("Working directory:", getwd()))

output_file <- file.path(getwd(), "test-results.xml")

results <- test_dir("tests", reporter = JunitReporter$new(file = output_file))

print(paste("Tests completed: ", output_file))
