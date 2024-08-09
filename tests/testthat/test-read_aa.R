test_that("read_aa reads an Agilaire basic data export", {
  expect_type(read_aa("C:/Data Analysis/Testing/data/BasicDataExportReport.csv"),
              type = "list")
})
