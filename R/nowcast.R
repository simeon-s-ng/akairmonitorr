# nowcast.R
# Calculation of the PM NowCast API as described in the EPA Technical Asssistance Document
# https://document.airnow.gov/technical-assistance-document-for-the-reporting-of-daily-air-quailty.pdf

#' nowcast
#'
#' @param data PM Dataset
#' @param pm_col PM Column Name
#'
#' @return
#' @export
nowcast <- function(data) {

  # 1. Select minimum and maximum PM measurements

}

#' Valid NowCast hour if 2 out of the last 3 hours of data are valid.
#'
#' @param data PM Dataset
#'
#' @return Boolean if hour is valid
#' @export
valid_nowcast <- function(data) {
  if(sum(is.na(data)) > length(data) / 3) {
    return(FALSE)
  }
  else {
    return(TRUE)
  }
}
