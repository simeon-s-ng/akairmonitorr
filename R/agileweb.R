# agileweb.R
# URL Information
# Base URL is the AgileWeb URL, followed by /api/
# DEC AgileWeb:
# https://dec.alaska.gov/air/air-monitoring/responsibilities/database-management/alaska-air-quality-real-time-data/AirVision/api

#' Query AMQA internal agileweb server for site/parameter data.
#'
#' @param sites Site name string. Optionally a comma-separated list of site names. (Site names are identical as listed in AirVision > Configuration Editors > Site/Parameter)
#' @param parameters Parameter string. Optionally a comma-separated list of parameter names. (Parameter names are identical as listed in AirVision > Configuration Editors > Site/Parameters)
#' @param interval Interval string. Defaults to 001h.
#' @param start Start date/time in format yyyy-mm-ddTHH:mm:ss
#' @param end End date/time in format yyyy-mm-ddTHH:mm:ss. Defaults to current time.
#'
#' @return A tibble with selected columns.
#' @export
query_agileweb <- function(sites, parameters, interval = NULL, start, end = NULL) {
  api_key <- rstudioapi::askForPassword(prompt = "Please enter your Agileweb API key")
  if(is.null(interval)) {
    interval <- "001h"
  }
  if(is.null(end)) {
    end <- agileweb_dt(lubridate::now())
  }
  req <- httr2::request(
    paste0(
      "https://dec.alaska.gov/applications/air/airvision/api/averagedata?",
      "sites=", sites, "&",
      "parameters=", parameters, "&",
      "interval=", interval, "&",
      "start=", start, "&",
      "end=", end
    )
  ) |>
    httr2::req_headers("APIKEY" = api_key, .redact = "Secret") |>
    httr2::req_headers("Accept" = "text/csv")
  req
  resp <- httr2::req_perform(req) |>
    httr2::resp_body_string() |>
    readr::read_csv()
  return(
    resp |>
      dplyr::select(
        "Date", "SiteName", "ParameterName", "ReportedUnitName", "IntervalName", "IsValid", "ReportValue", "FlagString"
      )
  )
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
  aw_dt <- as.character(datetime)
  return(
    aw_dt_glued <- stringr::str_glue(
      stringr::str_sub(aw_dt, 1, 10),
      "T",
      stringr::str_sub(aw_dt, 12, 19)
    )
  )
}
