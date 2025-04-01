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
  # 1. Select minimum and maximum PM measurements
  range <- max(data) - min(data)
  roc <- range / max(data)
  wf <- 1 - roc

  if(wf < 0.5) {
    wf <- 0.5
  }

  data <- tibble::as_tibble_col(data, column_name = "data") |>
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
