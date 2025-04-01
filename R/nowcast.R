# nowcast.R
# Calculation of the PM NowCast API as described in the EPA Technical Asssistance Document
# https://document.airnow.gov/technical-assistance-document-for-the-reporting-of-daily-air-quailty.pdf

#' nowcast
#'
#' @param data PM Dataset
#'
#' @return NowCast AQI value
#' @export
nowcast <- function(data) {
  data <- tibble::as_tibble_col(data, column_name = "data") |>
    filter(!is.na(data))

  range <- max(data) - min(data)
  roc <- range / max(data)
  wf <- 1 - roc

  if(!is.na(wf) & wf < 0.5) {
    wf <- 0.5
  }

  data <- data |>
    dplyr::mutate(hours_ago = 12 - dplyr::row_number()) |>
    dplyr::mutate(
      wf_mult = data * (wf ^ hours_ago),
      factor = wf ^ hours_ago
    ) |>
    dplyr::summarise(wf_sum = sum(wf_mult) / sum(factor))

  return(data$wf_sum)
}

#' Valid NowCast hour if 2 out of the last 3 hours of data are valid.
#'
#' @param data PM Dataset
#'
#' @return Boolean if hour is valid
#' @export
valid_nowcast <- function(data) {
  if(sum(is.na(data)) > length(data) / 3) {
    return(FALSE)
  }
  else {
    return(TRUE)
  }
}

#' Converts a value to an AQI value
#'
#' @param value NowCast calculated value
#'
#' @return An AQI value
#' @export
convert_aqi_pm25 <- function(value) {
  ifelse(
    is.na(value),
    return(NA),
    next
  )

  value <- trunc(value * 10) / 10

  if(value >= 0 && value <= 9.0) {
    bpl <- 0.0
    bph <- 9.0
    ilo <- 0
    ihi <- 50
  } else if (value >= 9.1 && value <= 35.4) {
    bpl <- 9.1
    bph <- 35.4
    ilo <- 51
    ihi <- 100
  } else if (value >= 35.5 && value <= 55.4) {
    bpl <- 35.5
    bph <- 55.4
    ilo <- 101
    ihi <- 150
  } else if (value >= 55.5 && value <= 125.4) {
    bpl <- 55.5
    bph <- 125.4
    ilo <- 151
    ihi <- 200
  } else if (value >= 125.5 && value <= 225.4) {
    bpl <- 125.5
    bph <- 225.4
    ilo <- 201
    ihi <- 300
  } else {
    bpl <- 225.5
    bph <- 325.4
    ilo <- 301
    ihi <- 500
  }

  return(round(((ihi - ilo) / (bph - bpl)) * (value - bpl) + ilo))

}
