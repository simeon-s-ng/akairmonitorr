# Quant PM25 Temporal Plot

Quant PM25 Temporal Plot

## Usage

``` r
plot_quant_pm25(data, town, cols = NULL, ...)
```

## Arguments

- data:

  Quant data in Agilaire basic data export format.

- town:

  Quant town location.

- cols:

  Optional plot color.

- ...:

  Additional pass-through arguments

## Value

A PM2.5 temporal plot.

## Examples

``` r
data <- read_aa("C:/Data Analysis/Testing/data/haines_quant.csv")
#> Error: 'C:/Data Analysis/Testing/data/haines_quant.csv' does not exist.
plot_quant_pm25(data, "Haines")
#> Error in UseMethod("filter"): no applicable method for 'filter' applied to an object of class "function"
```
