#' Read an Agilaire File
#'
#' Reads a basic data export file from Agilaire/AirVision and reformats
#' data into useable form.
#'
#' @param file The path to the file.
#'
#' @return Agilaire data in tibble form.
#' @export
#' @examples
#' file_path <- "C:/Data Analysis/Testing/data/BasicDataExportReport.csv"
#' basic_data_aa <- read_aa(file_path)
#' gt::gt_preview(basic_data_aa, top_n = 10, incl_rownums = FALSE)
read_aa <- function(file) {
  aa_file <- readr::read_csv(file, show_col_types = FALSE) %>%
    janitor::row_to_names(row_number = 1, remove_rows_above = TRUE) %>%
    janitor::clean_names() %>%
    dplyr::rename(date = na) %>%
    dplyr::filter(!dplyr::row_number() %in% c(1)) %>%
    dplyr::mutate(date = lubridate::parse_date_time(date, "dmy HM"))
  # Convert columns to numeric
  aa_file <- aa_file %>%
    dplyr::mutate_at(c(2:length(aa_file)), as.numeric)
}

#' Reads an Agilaire Quant Flagged Data Export
#'
#' @param file The path to the file.
#'
#' @return Agilaire data in tibble form.
#' @export
read_quant_flagged <- function(file) {
  aa_file <- readr::read_csv(
    file,
    progress = readr::show_progress(),
    name_repair = "minimal",
    show_col_types = FALSE,
    skip_empty_rows = FALSE,
  )
  colnames(aa_file)[1] <- "Date"
  names(aa_file) <- paste(names(aa_file), aa_file[1, ], aa_file[3, ], sep = "_")
  aa_file |>
    dplyr::rename_with(~stringr::str_remove(., "Quant_MOD00")) |>
    dplyr::rename(Date = Date_NA_Date) |>
    dplyr::filter(!dplyr::row_number() %in% c(1, 2, 3)) |>
    dplyr::mutate(Date = lubridate::parse_date_time(Date, "dmy HM"))
}

#' Reads an Agilaire Regulatory Flagged Data Export
#'
#' @param file The path to the file.
#' @param site The Regulatory site name as a string. This should match the site name exported from AA.
#'
#' @return Agilaire data in tibble form.
#' @export
read_regulatory_flagged <- function(file, site) {
  aa_file <- readr::read_csv(
    file,
    progress = readr::show_progress(),
    name_repair = "minimal",
    show_col_types = FALSE,
    skip_empty_rows = FALSE,
  )
  colnames(aa_file)[1] <- "Date"
  names(aa_file) <- paste(names(aa_file), aa_file[1, ], aa_file[3, ], sep = "_")
  aa_file |>
    dplyr::rename_with(~stringr::str_remove(., paste(site, "_", sep = ""))) |>
    dplyr::rename(Date = Date_NA_Date) |>
    dplyr::filter(!dplyr::row_number() %in% c(1, 2, 3)) |>
    dplyr::mutate(Date = lubridate::parse_date_time(Date, "dmy HM"))
}
