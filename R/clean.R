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
      dplyr::filter(!is.na(pm25), IsValid == TRUE) |>
      dplyr::select(date, pm25)
  )
}

#' Cleans Garden Quant Imported from AA
#'
#' @param data Tibble imported using the read_quant_flagged() function
#' @param pod MODULAIR Pod #
#'
#' @return Clean tibble of Quant data.
#' @export
clean_garden_quant <- function(data, pod) {
  data |>
    dplyr::select(
      Date,
      ((dplyr::starts_with(pod) & dplyr::ends_with("Value")) & (!dplyr::contains(c("NO_", "NO2_", "OZONE"))))
    ) |>
    dplyr::rename_with(~ stringr::str_remove(., paste0(pod, "_"))) |>
    dplyr::rename_with(~ stringr::str_remove(., "_Value"))
  # Convert columns to numeric
  data <- data |>
    dplyr::mutate_at(c(2:length(data)), as.numeric)

  return(data)
}

#' Cleans NCore Quant Imported from AA
#'
#' @param data Tibble imported using the read_quant_flagged() function
#' @param pod MODULAIR Pod #
#'
#' @return Clean tibble of Quant data.
#' @export
clean_ncore_quant <- function(data, pod) {
  dplyr::select(Date, (dplyr::starts_with(pod) & dplyr::ends_with("Value"))) |>
    dplyr::rename_with(~ stringr::str_remove(., paste0(pod, "_"))) |>
    dplyr::rename_with(~ stringr::str_remove(., "_Value"))
  # Convert columns to numeric
  data <- data |>
    dplyr::mutate_at(c(2:length(data)), as.numeric)

  return(data)
}

