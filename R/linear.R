#' Linear Regression Analysis
#'
#' @param data Data to analyze
#' @param x String of column of independent variable
#' @param y String of column of dependent variable
#'
#' @return Vector of lm coefficients
#' @export
#'
#' @examples
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
