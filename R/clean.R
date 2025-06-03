#' Extracts PM2.5 data from an Agileweb query.
#'
#' @param data Tibble from an agileweb query.
#'
#' @return Clean tibble with date and PM2.5 sample.
#' @export
clean_pm25 <- function(data) {
  return(
    data |>
      dplyr::rename(date = Date, site_name = SiteName, pm25 = ReportValue) |>
      dplyr::filter(!is.na(pm25), IsValid == TRUE) |>
      dplyr::select(date, site_name, pm25)
  )
}

#' Extracts PM10 data from an Agileweb query.
#'
#' @param data Tibble from an agileweb query.
#'
#' @return Clean tibble with date and PM10 sample.
#' @export
clean_pm10 <- function(data) {
  return(
    data |>
      dplyr::rename(date = Date, site_name = SiteName, pm10 = ReportValue) |>
      dplyr::filter(!is.na(pm10), IsValid == TRUE) |>
      dplyr::select(date, site_name, pm10)
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
  data <- data |>
    dplyr::select(
      Date,
      ((dplyr::starts_with(pod) & dplyr::ends_with("Value")) & (!dplyr::contains(c("NO_", "NO2_", "OZONE"))))
    ) |>
    dplyr::rename_with(~ stringr::str_remove(., paste0(pod, "_"))) |>
    dplyr::rename_with(~ stringr::str_remove(., "_Value"))
  # Convert columns to numeric // Add dewpoint col
  data <- data |>
    dplyr::mutate_at(c(2:length(data)), as.numeric) |>
    # DEWPOINT FOMULA: https://bmcnoldy.earth.miami.edu/Humidity.html
    dplyr::mutate(
      DEWPT = 243.04 * (log(RELHUM / 100) + ((17.625 * AMBTEMP) / (243.04 + AMBTEMP))) / (17.625 - log(RELHUM /100) - ((17.625 * AMBTEMP) / (243.04 + AMBTEMP)))
    )

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
  data <- data |>
    dplyr::select(Date, (dplyr::starts_with(pod) & dplyr::ends_with("Value"))) |>
    dplyr::rename_with(~ stringr::str_remove(., paste0(pod, "_"))) |>
    dplyr::rename_with(~ stringr::str_remove(., "_Value"))
  # Convert columns to numeric
  data <- data |>
    dplyr::mutate_at(c(2:length(data)), as.numeric) |>
    # DEWPOINT FOMULA: https://bmcnoldy.earth.miami.edu/Humidity.html
    dplyr::mutate(
      DEWPT = 243.04 * (log(RELHUM / 100) + ((17.625 * AMBTEMP) / (243.04 + AMBTEMP))) / (17.625 - log(RELHUM /100) - ((17.625 * AMBTEMP) / (243.04 + AMBTEMP)))
    )

  return(data)
}

#' Cleans Regulatory Data Imported from AA
#'
#' @param data Tibble imported using the read_regulatory_flagged() function
#'
#' @return Clean tibble of regulatory data.
#' @export
clean_regulatory <- function(data) {
  data <- data |>
    dplyr::select(Date, (dplyr::ends_with("Value"))) |>
    dplyr::rename_with(~ stringr::str_remove(., "_Value"))
  # Convert columns to numeric
  data <- data |>
    dplyr::mutate_at(c(2:length(data)), as.numeric)

  return(data)
}

#' Cleans a Joined Quant/BAM dataset for PM2.5
#'
#' @param data A joined Quant/BAM dataset
#'
#' @return A cleaned PM2.5 dataset
#' @export
clean_pm25_qt_bam <- function(data) {
  pm25_data <- data |>
    dplyr::select(
      Date = Date,
      PM25QT = PM25,
      PM25RG = PM25L,
      AMBTEMP = AMBTEMP_REG,
      RELHUM = RELHUM_REG,
      DEWPT = DEWPT_REG
    ) |>
    tidyr::pivot_longer(cols = c(PM25QT, PM25RG), names_to = "Monitor", values_to = "PM25") |>
    dplyr::mutate(Monitor = dplyr::if_else(Monitor == "PM25QT", "Quant", "BAM"))

  return(pm25_data)
}

#' Cleans a Joined Quant/BAM dataset for PM10
#'
#' @param data A joined Quant/BAM dataset
#'
#' @return A cleaned CO dataset
#' @export
clean_pm10_qt_bam <- function(data) {
  pm10_data <- data |>
    dplyr::select(
      Date = Date,
      PM10QT = PM10_CONTIN,
      PM10RG = PM10L,
      AMBTEMP = AMBTEMP_REG,
      RELHUM = RELHUM_REG,
      DEWPT = DEWPT_REG
    ) |>
    tidyr::pivot_longer(cols = c(PM10QT, PM10RG), names_to = "Monitor", values_to = "PM10") |>
    dplyr::mutate(Monitor = dplyr::if_else(Monitor == "PM10QT", "Quant", "BAM"))

  return(pm10_data)
}

#' Cleans a Joined Quant/BAM dataset for CO
#'
#' @param data A joined Quant/BAM dataset
#'
#' @return A cleaned CO dataset
#' @export
clean_co_qt_bam <- function(data) {
  co_data <- data |>
    dplyr::select(
      Date = Date,
      COQT = CO_PPM_QT,
      CORG = CO_PPM_REG,
      PM10RG = PM10L,
      AMBTEMP = AMBTEMP_REG,
      RELHUM = RELHUM_REG,
      DEWPT = DEWPT_REG
    ) |>
    tidyr::pivot_longer(cols = c(COQT, CORG), names_to = "Monitor", values_to = "CO") |>
    dplyr::mutate(Monitor = dplyr::if_else(Monitor == "COQT", "Quant", "BAM"))

  return(co_data)
}

#' Create a Joined Quant Dataset
#'
#' @param quant1 Quant 1 dataset
#' @param quant2 Quant 2 dataset
#' @param suffixes Quant SNs
#'
#' @return A cleaned Quant/Quant dataset
#' @export
clean_qt_to_qt <- function(quant1, quant2, suffixes) {
  quant1 <- quant1 |>
    dplyr::mutate(Monitor = suffixes[1])
  quant2 <- quant2 |>
    dplyr::mutate(Monitor = suffixes[2])

  quants <- dplyr::bind_rows(quant1, quant2)
  return(quants)
}

