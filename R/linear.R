#' Linear Regression Analysis
#'
#' @param data Data to analyze
#' @param x String of column of independent variable
#' @param y String of column of dependent variable
#'
#' @return Vector of lm coefficients
#' @export
linear_regression <- function(
    data,
    x,
    y,
    title = NULL,
    xlab = NULL,
    ylab = NULL
  ) {
  formula <- as.formula(paste0(y, '~', x))
  mod <- lm(formula, data)
  table <- moderndive::get_regression_table(mod)
  sum <- moderndive::get_regression_summaries(mod)

  caption <- paste0(
      "y = ",
      round(table[[2]][2], digits = 3),
      "x + ",
      round(table[[2]][1], digits = 3),
      "\n",
      "r\u00b2 = ",
      round(sum[[1]], digits = 3),
      "\n",
      "rmse = ",
      round(sum[[4]], digits = 3)
    )

  plot <- akairmonitorr::plot_lm(
    data,
    title,
    xlab,
    ylab,
    caption
  )

  show(plot)

  return(mod)
}


#' Calculate average percent difference between two sensors
#'
#' @param data Dataset with wide pivoted sensor/pollutant columns
#' @param col1 Name of column of sample measurements of sensor 1
#' @param col2 Name of column of sample measurements of sensor 2
#'
#' @return Average percent difference of two sensors
#' @export
avg_pct_diff <- function(data, col1, col2) {
  data <- data |>
    dplyr::mutate(abs_diff = (abs(.data[[col1]]) - .data[[col2]]) / (0.5 * (.data[[col1]] + .data[[col2]])) * 100) |>
    dplyr::summarize(mean(abs_diff))
  return(data)
}
