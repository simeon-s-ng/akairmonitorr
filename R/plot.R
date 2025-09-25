# ---- PLOT HELPERS ============================================================

#' Custom DEC ggplot2 Theme
#'
#' @return A ggplot2 custom theme
#' @export
#'
dec_plot_theme <- function() {
  ggplot2::theme(
    # border
    panel.border = ggplot2::element_rect(fill = NA, color = "#000000", linewidth = 1, linetype = 1),
    # background color
    panel.background = ggplot2::element_rect(fill = "#ffffff"),
    # plot.background = ggplot2::element_rect(fill = "#ffffff"),
    # legend.background = ggplot2::element_rect(fill = "#f7f5f2"),
    # grid
    panel.grid.major.x = ggplot2::element_line(color = "#aaaaaa", linewidth = 0.5, linetype = 1),
    panel.grid.minor.x = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color = "#aaaaaa", linewidth = 0.5, linetype = 1),
    panel.grid.minor.y = ggplot2::element_blank(),
    # axis
    axis.ticks = ggplot2::element_line(color = "#000000"),
    # title
    title = ggplot2::element_text(size = 8)
  )
}

# ---- GENERIC PLOTS ===========================================================

#' Linear Model Plot for any Pollutant & Monitor(s)
#'
#' @param data Pollutant Dataset. Must be in 'Date | Quant | BAM' form.
#' @param x Independent variable
#' @param y Dependent variable
#' @param title Title of the plot.
#' @param xlab X axis label.
#' @param ylab Y axis label.
#' @param caption Equation caption.
#'
#' @return A Linear Model ggplot
#' @export
plot_lm <- function(data, x, y, title, xlab, ylab, caption) {
  ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
    ggplot2::geom_point(
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::geom_smooth(method = lm, se = FALSE) +
    ggplot2::geom_abline(slope = 1, intercept = 0) +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = xlab, y = ylab, caption = caption) +
    akairmonitorr::dec_plot_theme() +
    ggplot2::theme(
      title = ggplot2::element_text(size = 10),
      plot.caption = ggplot2::element_text(size = 10)
    )
}

#' Linear Model Plot for any Pollutant & Monitor(s)
#'
#' @param data Pollutant Dataset. Must be in 'Date | Monitor | Pollutant' form.
#' @param title Title of the plot.
#' @param ind Independent variable.
#' @param dep Dependent variable.
#' @param pollutant Pollutant to compare.
#'
#' @return A Linear Model ggplot
#' @export
plot_lm_quant <- function(data, title, ind, dep, pollutant) {
  plot_data <- data |>
    dplyr::select(Date, Monitor, dplyr::any_of(pollutant)) |>
    tidyr::pivot_wider(id_cols = Date, names_from = Monitor, values_from = .data[[pollutant]])

  renameX <- paste0("Quant_", ind)
  renameY <- paste0("Quant_", dep)

  plot_data <- plot_data |>
    dplyr::rename(!!renameX := .data[[ind]], !!renameY := .data[[dep]])

  model <- parsnip::linear_reg()
  formula <- paste0(renameY, ' ~ ', renameX) |>
    as.formula()
  fit <- model |>
    parsnip::fit(formula, data = plot_data)

  fit_tidy <- parsnip::tidy(fit)
  fit_glance <- parsnip::glance(fit)

  fit_int   <- fit_tidy$estimate[1]
  fit_slope <- fit_tidy$estimate[2]
  fit_r2    <- fit_glance$r.squared
  fit_rmse  <- yardstick::rmse(plot_data, renameX, renameY)

  caption <- paste0(
      "y = ",
      round(fit_slope, digits = 3),
      "x + ",
      round(fit_int, digits = 3),
      "\n",
      "r\u00b2 = ",
      round(fit_r2, digits = 3)
    )

  xlab <- paste0(renameX, "_", pollutant)
  ylab <- paste0(renameY, "_", pollutant)

  ggplot2::ggplot(plot_data, ggplot2::aes(x = .data[[renameX]], y = .data[[renameY]])) +
    ggplot2::geom_point(
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::geom_smooth(method = lm) +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = xlab, y = ylab, caption = caption) +
    akairmonitorr::dec_plot_theme() +
    ggplot2::theme(plot.caption = ggplot2::element_text(size = 8))
}

#' Loess Regression Plot for any Pollutant & Monitor(s)
#'
#' @param data Pollutant Dataset. Must be in 'Date | Quant | BAM' form.
#' @param x Independent variable
#' @param y Dependent variable
#' @param title Title of the plot.
#' @param xlab X axis label.
#' @param ylab Y axis label.
#' @param caption Equation caption.
#'
#' @return A Loess Smooth Line ggplot
#' @export
plot_loess <- function(data, x, y, title, xlab, ylab, caption = NULL) {
  ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
    ggplot2::geom_point(
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::geom_smooth(method = "loess", se = FALSE) +
    ggplot2::geom_abline(slope = 1, intercept = 0) +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = xlab, y = ylab, caption = caption) +
    akairmonitorr::dec_plot_theme() +
    ggplot2::theme(
      title = ggplot2::element_text(size = 10),
      plot.caption = ggplot2::element_text(size = 10)
    )
}

#' Median Regression Plot for any Pollutant & Monitor(s)
#'
#' @param data Pollutant Dataset. Must be in 'Date | Quant | BAM' form.
#' @param title Title of the plot.
#' @param xlab X axis label.
#' @param ylab Y axis label.
#' @param caption Equation caption.
#'
#' @return A Median Regression ggplot
#' @export
plot_rq <- function(data, x, y, title, xlab, ylab, caption = NULL) {
  ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
    ggplot2::geom_point(
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::geom_quantile(quantiles = 0.5) +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    ggplot2::labs(x = xlab, y = ylab, caption = caption) +
    akairmonitorr::dec_plot_theme() +
    ggplot2::theme(plot.caption = ggplot2::element_text(size = 8))
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
      ggplot2::ylab("PM2.5 (\u03bcg/m\u00b3)") +
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

#' PM2.5 Diurnal Plot
#'
#' @param data Data for plot.
#' @param pollutant Pollutant name as a string (usually column name).
#' @param sites Site name or list of sites.
#' @param title A string for the title of the plot.
#' @param statistic A string "median" or "mean"
#'
#' @return A Compilation of Diurnal Plots.
#'
#' @examples
#' \dontrun{
#' plot_diurnal(quant_pm25, "pm25", c("Bethel", "Napaskiak"), "Example Plot", "median")
#' }
#'
#' @export
plot_diurnal <- function(data, pollutant, sites, title, statistic) {
  # Initial Cleaning ----
  diurnal_data <- data |>
    dplyr::filter(site_name %in% sites) |>
    dplyr::rename(site = site_name) |>
    dplyr::mutate(
      hour = lubridate::hour(date),
      day = lubridate::wday(date, week_start = 1),
      day_name = lubridate::wday(date, label = TRUE, week_start = 1),
      month = lubridate::month(date),
      year = lubridate::year(date),
      date = date
    )

  if (statistic == "mean") {
    # Grouped by hours
    diurnal_hour <- diurnal_data |>
      dplyr::group_by(site, hour) |>
      dplyr::summarise("{pollutant}" := mean(.data[[pollutant]]))

    # Grouped by hour-weekdays
    diurnal_hour_week <- diurnal_data |>
      dplyr::group_by(site, hour, day, day_name) |>
      dplyr::summarise("{pollutant}" := mean(.data[[pollutant]]))

    # Grouped by weekday
    diurnal_wd <- diurnal_data |>
      dplyr::group_by(site, day, day_name) |>
      dplyr::summarise("{pollutant}" := mean(.data[[pollutant]]))

    # Grouped by month
    diurnal_month <- diurnal_data |>
      dplyr::group_by(site, year, month) |>
      dplyr::summarise("{pollutant}" := mean(.data[[pollutant]])) |>
      dplyr::mutate(date = lubridate::parse_date_time(paste0(year, "-", month), "ym"))
  }
  else if(statistic == "median") {
    # Grouped by hours
    diurnal_hour <- diurnal_data |>
      dplyr::group_by(site, hour) |>
      dplyr::summarise("{pollutant}" := median(.data[[pollutant]]))

    # Grouped by hour-weekdays
    diurnal_hour_week <- diurnal_data |>
      dplyr::group_by(site, hour, day, day_name) |>
      dplyr::summarise("{pollutant}" := median(.data[[pollutant]]))

    # Grouped by weekday
    diurnal_wd <- diurnal_data |>
      dplyr::group_by(site, day, day_name) |>
      dplyr::summarise("{pollutant}" := median(.data[[pollutant]]))

    # Grouped by month
    diurnal_month <- diurnal_data |>
      dplyr::group_by(site, year, month) |>
      dplyr::summarise("{pollutant}" := median(.data[[pollutant]])) |>
      dplyr::mutate(date = lubridate::parse_date_time(paste0(year, "-", month), "ym"))
  }

  # Plots ----

  hw_plot <- diurnal_hour_week |>
    ggplot2::ggplot(ggplot2::aes(hour, .data[[pollutant]], color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(expand = c(0, 0), breaks = seq(0, 23, 6)) +
      ggplot2::scale_y_continuous(
        expand = c(0, 0),
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
        limits = c(
          0.9 * min(subset(diurnal_hour_week, select = pollutant)),
          1.1 * max(subset(diurnal_hour_week, select = pollutant))
        )
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::facet_wrap(ggplot2::vars(day_name), nrow = 1) +
      ggplot2::theme(
        plot.margin = ggplot2::margin(0, 0, 0, 0, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  h_plot <- diurnal_hour |>
    ggplot2::ggplot(ggplot2::aes(hour, .data[[pollutant]], color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(expand = c(0, 0), breaks = seq(0, 23, 6)) +
      ggplot2::scale_y_continuous(
        expand = c(0, 0),
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
        limits = c(
          0.9 * min(subset(diurnal_hour, select = pollutant)),
          1.1 * max(subset(diurnal_hour, select = pollutant))
        )
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 1.5, 1.5, 1.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  m_plot <- diurnal_month |>
    ggplot2::ggplot(ggplot2::aes(date, .data[[pollutant]], color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::guides(fill = 'none') +
      ggplot2::scale_y_continuous(
        expand = c(0, 0),
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
        limits = c(
          0.9 * min(subset(diurnal_month, select = pollutant)),
          1.1 * max(subset(diurnal_month, select = pollutant))
        )
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 1.5, 1.5, 2.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  wd_plot <- diurnal_wd |>
    ggplot2::ggplot(ggplot2::aes(day, .data[[pollutant]], color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(
        expand = c(0, 0),
        labels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
      ) +
      ggplot2::scale_y_continuous(
        expand = c(0, 0),
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
        limits = c(
          0.9 * min(subset(diurnal_wd, select = pollutant)),
          1.1 * max(subset(diurnal_wd, select = pollutant))
        )
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 2.5, 1.5, 1.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  diurnal_patched <- hw_plot /
    (h_plot + wd_plot + m_plot +
      patchwork::plot_layout(
        axis_titles = "collect_y",
        guides = "collect"
      )
    ) +
    patchwork::plot_layout(
      guides = "collect"
    ) +
    patchwork::plot_annotation(
      title = title,
      theme = ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
    ) &
    ggplot2::theme(
      legend.position = 'bottom'
    )

  return(diurnal_patched)
}

#' Diurnal Plot - Community Call
#'
#' @param data Quant data for plot
#' @param site A string Quant sensor name
#' @param start Start date
#' @param end End date
#' @param statistic A string "Median" or "Mean"
#' @param title Plot title
#'
#' @return Diurnal ggplot
#' @export
plot_diurnal_cc <- function(data, site, start, end, statistic, title) {
  plot_data <- data |>
    dplyr::filter(site_name %in% site, date >= start, date <= end, pm25 <= 50) |>
    dplyr::rename(site = site_name) |>
    dplyr::mutate(
      hour = lubridate::hour(date),
      day = lubridate::wday(date, week_start = 1),
      day_name = lubridate::wday(date, label = TRUE, week_start = 1),
      month = lubridate::month(date),
      year = lubridate::year(date),
      date = date
    )

  if (statistic == "Mean") {
    # Grouped by hours
    diurnal_hour <- plot_data |>
      dplyr::group_by(site, hour) |>
      dplyr::summarise(pm25 = mean(pm25))

    # Grouped by hour-weekdays
    diurnal_hour_week <- plot_data |>
      dplyr::group_by(site, hour, day, day_name) |>
      dplyr::summarise(pm25 = mean(pm25))

    # Grouped by weekday
    diurnal_wd <- plot_data |>
      dplyr::group_by(site, day, day_name) |>
      dplyr::summarise(pm25 = mean(pm25))

    # Grouped by month
    diurnal_month <- plot_data |>
      dplyr::group_by(site, month) |>
      dplyr::summarise(pm25 = mean(pm25)) |>
      dplyr::mutate(date = lubridate::month(month, label = TRUE, abbr = TRUE))
  }
  else if(statistic == "Median") {
    # Grouped by hours
    diurnal_hour <- plot_data |>
      dplyr::group_by(site, hour) |>
      dplyr::summarise(pm25 = median(pm25))

    # Grouped by hour-weekdays
    diurnal_hour_week <- plot_data |>
      dplyr::group_by(site, hour, day, day_name) |>
      dplyr::summarise(pm25 = median(pm25))

    # Grouped by weekday
    diurnal_wd <- plot_data |>
      dplyr::group_by(site, day, day_name) |>
      dplyr::summarise(pm25 = median(pm25))

    # Grouped by month
    diurnal_month <- plot_data |>
      dplyr::group_by(site, month) |>
      dplyr::summarise(pm25 = median(pm25)) |>
      dplyr::mutate(date = lubridate::month(month, label = TRUE, abbr = TRUE))
  }

  hw_plot <- diurnal_hour_week |>
    ggplot2::ggplot(ggplot2::aes(hour, pm25, color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(expand = c(0, 0), breaks = seq(0, 23, 6)) +
      ggplot2::scale_y_continuous(
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::facet_wrap(ggplot2::vars(day_name), nrow = 1) +
      ggplot2::theme(
        plot.margin = ggplot2::margin(0, 0, 0, 0, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  h_plot <- diurnal_hour |>
    ggplot2::ggplot(ggplot2::aes(hour, pm25, color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(expand = c(0, 0), breaks = seq(0, 23, 6)) +
      ggplot2::scale_y_continuous(
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 1.5, 1.5, 1.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  m_plot <- diurnal_month |>
    ggplot2::ggplot(ggplot2::aes(factor(date), pm25, color = site)) +
      ggplot2::geom_line(ggplot2::aes(y = pm25), linewidth = 1, lineend = "round") +
      ggplot2::guides(fill = 'none') +
      ggplot2::scale_y_continuous(
        expression("PM"["2.5"] ~ "(\u03bcg/m\u00b3)"),
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 1.5, 1.5, 2.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  wd_plot <- diurnal_wd |>
    ggplot2::ggplot(ggplot2::aes(day, pm25, color = site)) +
      ggplot2::geom_line(linewidth = 1, lineend = "round") +
      ggplot2::scale_x_continuous(
        expand = c(0, 0),
        labels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
      ) +
      ggplot2::scale_y_continuous(
        "PM2.5 (\u03bcg/m\u00b3)"
      ) +
      ggplot2::scale_color_brewer(palette = "Set1") +
      akairmonitorr::dec_plot_theme() +
      ggplot2::theme(
        plot.margin = ggplot2::margin(1.5, 2.5, 1.5, 1.5, 'pt'),
        panel.spacing = ggplot2::unit(0, "lines")
      )

  diurnal_patched <- hw_plot /
    (h_plot + wd_plot + m_plot +
      patchwork::plot_layout(
        axis_titles = "collect_y",
        guides = "collect"
      )
    ) +
    patchwork::plot_layout(
      guides = "collect"
    ) +
    patchwork::plot_annotation(
      title = title,
      theme = ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
    ) &
    ggplot2::theme(
      legend.position = 'bottom'
    )

  return(diurnal_patched)
}

# ---- PM10 PLOTS ==============================================================

#' PM10 Time Series plot for any Monitor(s)
#'
#' @param data PM10 Dataset. Must be in 'Date | PM10 | Monitor' form.
#' @param title Title of plot.
#'
#' @return A PM10 time series ggplot
#' @export
plot_pm10_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
    ggplot2::geom_point(
      ggplot2::aes(x = Date, y = PM10, color = Monitor, shape = Monitor),
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
    ggplot2::ylab('PM10 (\u03bcg/m\u00b3)') +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    akairmonitorr::dec_plot_theme()
}

# ---- CO PLOTS ================================================================
#' CO Time Series plot for any Monitor(s)
#'
#' @param data CO Dataset. Must be in 'Date | CO | Monitor' form.
#' @param title Title of plot.
#'
#' @return A CO time series ggplot
#' @export
plot_co_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
    ggplot2::geom_point(
      ggplot2::aes(x = Date, y = CO, color = Monitor, shape = Monitor),
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
    ggplot2::ylab('CO (ppm)') +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    akairmonitorr::dec_plot_theme()
}

# ---- NO Plots ================================================================
#' NO Time Series plot for any Monitor(s)
#'
#' @param data NO Dataset. Must be in 'Date | NO | Monitor' form.
#' @param title Title of plot.
#'
#' @return A NO time series ggplot
#' @export
plot_no_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
    ggplot2::geom_point(
      ggplot2::aes(x = Date, y = NO, color = Monitor, shape = Monitor),
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
    ggplot2::ylab('NO (ppm)') +
    ggthemes::scale_color_gdocs() +
    ggplot2::ggtitle(title) +
    akairmonitorr::dec_plot_theme()
}

# ---- O3 Plots ================================================================
#' O3 Time Series plot for any Monitor(s)
#'
#' @param data O3 Dataset. Must be in 'Date | O3 | Monitor' form.
#' @param title Title of plot.
#'
#' @return A O3 time series ggplot
#' @export
plot_o3_ts_monitor <- function(data, title) {
  ggplot2::ggplot(data) +
    ggplot2::geom_point(
      ggplot2::aes(x = Date, y = O3, color = Monitor, shape = Monitor),
      alpha = 0.33,
      show.legend = TRUE
    ) +
    ggplot2::scale_x_datetime("Date", date_breaks = "1 month", date_labels = "%b") +
    ggplot2::ylab('O3 (ppb)') +
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
