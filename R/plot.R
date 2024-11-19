#' Custom DEC ggplot2 Theme
#'
#' @return A ggplot2 custom theme
#' @export
#'
dec_plot_theme <- function() {
  ggplot2::theme(
    # border
    panel.border = ggplot2::element_rect(fill = NA, color = "#3f78a7", linewidth = 1, linetype = 1),
    # background color
    panel.background = ggplot2::element_rect(fill = "#f7f5f2"),
    plot.background = ggplot2::element_rect(fill = "#f7f5f2"),
    # grid
    panel.grid.major.x = ggplot2::element_line(color = "#a1b9ed", linewidth = 0.5, linetype = 1),
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color = "#a1b9ed", linewidth = 0.5, linetype = 1),
    panel.grid.minor.y = ggplot2::element_blank(),
    # axis
    axis.ticks = ggplot2::element_line(color = "#3f78a7"),
    # title
    title = ggplot2::element_text(size = 8)
  )
}

#' Linear Model Plot for any Pollutant & Monitor(s)
#'
#' @param data Pollutant Dataset. Must be in 'Date | Quant | BAM' form.
#' @param title Title of the plot.
#' @param xlab X axis label.
#' @param ylab Y axis label.
#' @param caption Equation caption.
#'
#' @return A Linear Model ggplot
#' @export
plot_lm <- function(data, title, xlab, ylab, caption) {
  ggplot2::ggplot(data, ggplot2::aes(x = BAM, y = Quant)) +
    ggplot2::geom_point(
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::geom_smooth(method = lm) +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = xlab, y = ylab, caption = caption) +
    akairmonitorr::dec_plot_theme()
}

# ---- PM2.5 PLOTS =============================================================

#' Quant PM25 Temporal Plot
#'
#' @param data Quant data in Agilaire basic data export format.
#' @param town Quant town location.
#' @param cols Optional plot color.
#' @param ... Additional pass-through arguments
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

#' PM2.5 Time Series Plot for any Monitor(s)
#'
#' @param data PM2.5 Dataset. Must be in 'Date | PM25 | Monitor' form.
#' @param title Title of the plot.
#'
#' @return A PM2.5 time series ggplot
#' @export
plot_pm25_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
      ggplot2::geom_point(
        ggplot2::aes(x = Date, y = PM25, color = Monitor, shape = Monitor),
        alpha = 0.33,
        show.legend = TRUE
      ) +
      ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
      ggthemes::scale_color_gdocs() +
      ggplot2::ggtitle(title) +
      akairmonitorr::dec_plot_theme()
}


#' PM2.5 Box Plot for any Monitor(s)
#'
#' @param data PM2.5 Dataset. Must be in 'Date | PM25 | Monitor' form.
#' @param title Title of the plot.
#'
#' @return A PM2.5 boxplot.
#' @export
plot_pm25_box_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
      ggplot2::geom_boxplot(
        ggplot2::aes(x = Monitor, y = PM25, color = Monitor, shape = Monitor),
        show.legend = TRUE,
        outlier.shape = 1
      ) +
      ggthemes::scale_color_gdocs() +
      ggplot2::ggtitle(title) +
      akairmonitorr::dec_plot_theme()
}

# ---- PM10 PLOTS ==============================================================

#' PM10 Time Series plot for any Monitor(s)
#'
#' @param data PM2.5 Dataset. Must be in 'Date | PM10 | Monitor' form.
#' @param title Title of plot.
#'
#' @return A pm10 time series ggplot
#' @export
plot_pm10_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
    ggplot2::geom_point(
      ggplot2::aes(x = Date, y = PM10, color = Monitor, shape = Monitor),
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    akairmonitorr::dec_plot_theme()
}

# ---- MET PLOTS ===============================================================

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
