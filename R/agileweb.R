# agileweb.R
# URL Information
# Base URL is the AgileWeb URL, followed by /api/
# DEC AgileWeb:
# https://dec.alaska.gov/air/air-monitoring/responsibilities/database-management/alaska-air-quality-real-time-data/AirVision/api

#' Query AMQA internal agileweb server for site/parameter data.
#'
#' @param sites Site name string. Optionally a comma-separated list of site names (Site names are identical as listed in AirVision > Configuration Editors > Site/Parameter).
#' @param parameters Parameter string. Optionally a comma-separated list of parameter names (Parameter names are identical as listed in AirVision > Configuration Editors > Site/Parameters).
#' @param interval Interval string. Defaults to 001h.
#' @param start Start date/time in format yyyy-mm-ddTHH:mm:ss
#' @param end End date/time in format yyyy-mm-ddTHH:mm:ss. Defaults to current time.
#' @param api_key AirVision API Key - Ask Agilaire admins for API keys.
#'
#' @return A tibble with selected columns.
#' @export
query_agileweb <- function(
    sites = NULL,
    parameters = NULL,
    interval = NULL, start,
    end = NULL, api_key
  ) {
  # Default 1 hour interval
  if(is.null(interval)) {
    interval <- "001h"
  }
  # Default end date is midnight of present day.
  if(is.null(end)) {
    end <- agileweb_dt(lubridate::now())
  }
  # Default end_date_data is present datetime
  end_date_query <- lubridate::parse_date_time(end, "ymd HMS")
  end_date_data <- lubridate::parse_date_time(start, "ymd HMS")
  new_start_date <- start
  data <- NULL
  # Loop to keep querying agileweb when there are > 10k records in the date range.
  while(end_date_data < end_date_query) {
    req <- httr2::request(
      paste0(
        "https://dec.alaska.gov/applications/air/airvision/api/averagedata?",
        "sites=", stringr::str_replace_all(sites, " ", "%20"), "&",
        "parameters=", stringr::str_replace_all(parameters, " ", "%20"), "&",
        "interval=", interval, "&",
        "start=", new_start_date, "&",
        "end=", end
      )
    ) |>
      httr2::req_headers("APIKEY" = api_key, .redact = "Secret") |>
      httr2::req_headers("Accept" = "text/csv")
    req
    resp <- httr2::req_perform(req) |>
      httr2::resp_body_string() |>
      readr::read_csv(show_col_types = FALSE) |>
      dplyr::select(
          "Date",
          "SiteName",
          "ParameterName",
          "ReportedUnitName",
          "IntervalName",
          "IsValid",
          "ReportValue",
          "FlagString"
      )
    data <- dplyr::bind_rows(data, resp)
    end_date_data <- max(data$Date)
    new_start_date <- agileweb_dt(max(data$Date))
    test_length <- end_date_query - end_date_data
    # Stop querying if data within 2 hours of query end.
    if(lubridate::time_length(test_length, unit = "hour") < 3) {
      break
    }
  }
  return(data)
}

#' agileweb_dt
#'
#' @param datetime Datetime in POSIXct format.
#'
#' @return Datetime in required Agileweb API format.
#' @export
#'
#' @examples
#' end <- agileweb_dt(lubridate::now())
agileweb_dt <- function(datetime) {
  # If hour is 0
  if(lubridate::hour(datetime) == 0) {
    return(paste0(as.character(datetime), "T00:00:00"))
  }
  # Else glue and return full string
  aw_dt <- as.character(datetime)
  return(
    aw_dt_glued <- stringr::str_glue(
      stringr::str_sub(aw_dt, 1, 10),
      "T",
      stringr::str_sub(aw_dt, 12, 19)
    )
  )
}
