#' Quant PM25 Temporal Plot
#'
#' @param data Quant data in Agilaire basic data export format.
#' @param town Quant town location.
#' @param cols Optional plot color.
#'
#' @return A PM2.5 temporal plot.
#' @export
#'
#' @examples
#' data <- read_aa("C:/Data Analysis/Testing/data/haines_quant.csv")
#' plot_quant_pm25(data, "Haines")
plot_quant_pm25 <- function(data, town, cols = NULL) {
  # Artificial cutoff at 50ug/m3
  data <- data %>% dplyr::filter(pm25 <= 50)

  openair::timeVariation(
    data,
    pollutant = "pm25",
    statistic = "median",
    ylab = "PM25 (\\u00b5g/m\\u00b3)",
    cols = ifelse(!is.null(cols), cols, "cornflowerblue"),
    main = paste0(
      town,
      " Quant - Median PM25 Concentrations | ",
      format(lubridate::date(min(data$date)), "%m/%d/%Y"),
      " - ",
      format(lubridate::date(max(data$date)), "%m/%d/%Y")
    ),
    sub = "median"
  )
}
