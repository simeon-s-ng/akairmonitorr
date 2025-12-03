# Query AMQA internal agileweb server for site/parameter data.

Query AMQA internal agileweb server for site/parameter data.

## Usage

``` r
query_agileweb(
  sites = NULL,
  parameters = NULL,
  interval = NULL,
  start,
  end = NULL,
  api_key
)
```

## Arguments

- sites:

  Site name string. Optionally a comma-separated list of site names
  (Site names are identical as listed in AirVision \> Configuration
  Editors \> Site/Parameter).

- parameters:

  Parameter string. Optionally a comma-separated list of parameter names
  (Parameter names are identical as listed in AirVision \> Configuration
  Editors \> Site/Parameters).

- interval:

  Interval string. Defaults to 001h.

- start:

  Start date/time in format yyyy-mm-ddTHH:mm:ss

- end:

  End date/time in format yyyy-mm-ddTHH:mm:ss. Defaults to current time.

- api_key:

  AirVision API Key - Ask Agilaire admins for API keys.

## Value

A tibble with selected columns.
