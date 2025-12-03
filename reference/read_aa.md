# Read an Agilaire File

Reads a basic data export file from Agilaire/AirVision and reformats
data into useable form.

## Usage

``` r
read_aa(file)
```

## Arguments

- file:

  The path to the file.

## Value

Agilaire data in tibble form.

## Examples

``` r
file_path <- "C:/Data Analysis/Testing/data/BasicDataExportReport.csv"
basic_data_aa <- read_aa(file_path)
#> Error: 'C:/Data Analysis/Testing/data/BasicDataExportReport.csv' does not exist.
gt::gt_preview(basic_data_aa, top_n = 10, incl_rownums = FALSE)
#> Error: object 'basic_data_aa' not found
```
