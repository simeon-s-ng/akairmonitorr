#' Linear Regression Analysis
#'
#' @param data Data to analyze
#' @param x String of column of independent variable
#' @param y String of column of dependent variable
#'
#' @return Vector of lm coefficients
#' @export
linear_regression <- function(data, x, y) {
  formula <- as.formula(paste0(y, '~', x))
  mod <- parsnip::linear_reg()
  fit <- mod |>
    parsnip::fit(formula, data = data)

  fit_tidy <- parsnip::tidy(fit)
  fit_glance <- parsnip::glance(fit)

  fit_int   <- fit_tidy$estimate[1]
  fit_slope <- fit_tidy$estimate[2]
  fit_r2    <- fit_glance$r.squared
  fit_rmse  <- yardstick::rmse(data, .data[[x]], .data[[y]])

  return(c(fit_slope, fit_int, fit_r2, fit_rmse))
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
    mutate(abs_diff = (abs(.data[[col1]]) - .data[[col2]]) / (0.5 * (.data[[col1]] + .data[[col2]])) * 100) |>
    summarize(mean(abs_diff))
  return(data)
}
