
<!-- README.md is generated from README.Rmd. Please edit that file -->

# akairmonitor

<!-- badges: start -->
<!-- badges: end -->

Package for the AMQA data management team. Contains functions for the
common data cleaning & wrangling steps the team comes across.

## Installation

You can install the development version of akairmonitor from
[GitHub](https://github.com/simeon-s-ng/akairmonitor) with:

``` r
# install.packages("pak")
pak::pak("simeon-s-ng/akairmonitor")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(akairmonitor)

# .csv basic data export from Agilaire/AirVision
file_path <- "C:/Data Analysis/Testing/data/BasicDataExportReport.csv"
basic_data_aa <- read_aa(file_path)
#> New names:
#> • `` -> `...1`
#> • `Quant_MOD00462` -> `Quant_MOD00462...2`
#> • `Quant_MOD00462` -> `Quant_MOD00462...3`
#> • `Quant_MOD00462` -> `Quant_MOD00462...4`
#> • `Quant_MOD00462` -> `Quant_MOD00462...5`
#> • `Quant_MOD00462` -> `Quant_MOD00462...6`
#> • `Quant_MOD00462` -> `Quant_MOD00462...7`
#> • `Quant_MOD00462` -> `Quant_MOD00462...8`
#> • `Quant_MOD00462` -> `Quant_MOD00462...9`
#> • `Quant_MOD00462` -> `Quant_MOD00462...10`

head(basic_data_aa)
#> # A tibble: 6 × 10
#>   date                ambtemp co_ppb co_ppm no_ppb no2_ppb ozone_ppb pm10_contin
#>   <dttm>                <dbl>  <dbl>  <dbl>  <dbl>   <dbl>     <dbl>       <dbl>
#> 1 2024-07-01 00:00:00    13.8   244.   0.24   2.17    24.9      21.2           8
#> 2 2024-07-01 01:00:00    12.6   244.   0.24   1.86    24.6      16.8           7
#> 3 2024-07-01 02:00:00    12     245.   0.24   1.59    23.6      15.2           6
#> 4 2024-07-01 03:00:00    11.5   246.   0.24   1.62    23.6      16.1           6
#> 5 2024-07-01 04:00:00    12.1   237.   0.23   1.81    22.5      13             5
#> 6 2024-07-01 05:00:00    12.8   238    0.23   1.90    22.2      11.1           5
#> # ℹ 2 more variables: pm25 <dbl>, relhum <dbl>
```
