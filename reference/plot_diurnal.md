# PM2.5 Diurnal Plot

PM2.5 Diurnal Plot

## Usage

``` r
plot_diurnal(data, pollutant, sites, title, statistic)
```

## Arguments

- data:

  Data for plot.

- pollutant:

  Pollutant name as a string (usually column name).

- sites:

  Site name or list of sites.

- title:

  A string for the title of the plot.

- statistic:

  A string "median" or "mean"

## Value

A Compilation of Diurnal Plots.

## Examples

``` r
if (FALSE) { # \dontrun{
plot_diurnal(quant_pm25, "pm25", c("Bethel", "Napaskiak"), "Example Plot", "median")
} # }
```
