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
plot_quant_pm25 <- function(data, town, cols = NULL, ...) {
  # Artificial cutoff at 50ug/m3
  data <- data %>% dplyr::filter(pm25 <= 50)

  openair::timeVariation(
    data,
    pollutant = "pm25",
    statistic = "median",
    ylab = "PM25 (\\u00b5g/m\\u00b3)",
    cols = ifelse(!is.null(cols), cols, "#12436D"),
    main = paste0(
      town,
      " Quant - Median PM25 Concentrations | ",
      format(lubridate::date(min(data$date)), "%m/%d/%Y"),
      " - ",
      format(lubridate::date(max(data$date)), "%m/%d/%Y")
    ),
    ylim = list(c(0, 35), c(0, 35), c(0, 35), c(0, 35)),
    sub = "median"
  )
}

#' DEC AMQA Wind Rose
#' 
#' @param data Wind speed and wind direction data. Must have column names ("date", "wd", "ws").
#' @param title Title for the figure.
#' 
#' @return An openair Windrose
#' @export 
plot_wind_rose <- function(data, title) {
  openair::windRose(
    mydata = data,
    paddle = FALSE, 
    cols = c("#C1C1C1", "#81FFFE", "#7FFF81", "#FFFF01", "#FE0002", "#0000FE", "#FF00FF"),
    border = "#000000",
    offset = 5,
    key.position = "right",
    auto.text = FALSE,
    grid.line = list(value = 3.5, lty = 5),
    max.freq = 21,
    breaks = c(0.01, 0.50, 1.50, 3.10, 5.10, 8.20, 10.80),
    main = title
  )
}