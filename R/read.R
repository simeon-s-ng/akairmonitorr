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
