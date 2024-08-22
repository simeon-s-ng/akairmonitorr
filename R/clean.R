#' Extracts PM2.5 data from an Agileweb query.
#'
#' @param data Tibble from an agileweb query.
#'
#' @return Clean tibble with date and PM2.5 sample.
#' @export
clean_pm25 <- function(data) {
  return(
    data |>
      dplyr::rename(date = Date, pm25 = ReportValue) |>
      dplyr::filter(!is.na(pm25)) |>
      dplyr::select(date, pm25)
  )
}
