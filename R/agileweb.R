# agileweb.R
# URL Information
# Base URL is the AgileWeb URL, followed by /api/
# DEC AgileWeb:
# https://dec.alaska.gov/air/air-monitoring/responsibilities/database-management/alaska-air-quality-real-time-data/AirVision/api

#' Query AMQA internal agileweb server for site/parameter data.
#'
#' @param sites Site name string. Optionally a comma-separated list of site names (Site names are identical as listed in AirVision > Configuration Editors > Site/Parameter).
#' @param parameters Parameter string. Optionally a comma-separated list of parameter names (Parameter names are identical as listed in AirVision > Configuration Editors > Site/Parameters).
#' @param interval Interval string. Defaults to 001h.
#' @param start Start date/time in format yyyy-mm-ddTHH:mm:ss
#' @param end End date/time in format yyyy-mm-ddTHH:mm:ss. Defaults to current time.
#' @param api_key AirVision API Key - Ask Agilaire admins for API keys.
#'
#' @return A tibble with selected columns.
#' @export
query_agileweb <- function(sites, parameters, interval = NULL, start, end = NULL, api_key) {
  # Default 1 hour interval
  if(is.null(interval)) {
    interval <- "001h"
  }
  # Default end date is midnight of present day.
  if(is.null(end)) {
    end <- agileweb_dt(lubridate::now())
  }
  # Default parameters
  if(is.null(parameters)) {
    parameters <- "AMBTEMP,AmbT_10m,AmbT_23m,AmbT_3m,AspT_10m,AspT_2m,BARPRESS,BC,BP,CO,CO2,COPHTdr,COSampF,COSampP,CO_PPB,CO_PPM,CO_TShl,COmRatio,COmeas,COzRatio,NC_PM10_1_PMc,NO,NO2,NO2_PPB,NOYO3Flw,NOYPMTV,NOYRcPrs,NOYSampP,NOYaZero,NO_PPB,NOx,NOy,Noy-NO,O3,O3BenPA,O3BenPB,O3BenT,O3LampT,O3PhoPr,O3SampF,O3_Flow_T703U,O3_IntA,O3_IntB,O3_Press_T703U,OZONE_PPB,PM1,PM10,PM10L,PM10L_Qt,PM10S,PM10S_Qt,PM10_BP,PM10_CONTIN,PM10_RH,PM10_TShl,PM10_Tamb,PM25,PM25L,PM25_AT,PM25_BP,PM25_Qt,PM25_RH,PM25_TShl,PM25_Tamb,PMc,Quant_PM25_Corr,RELHUM,RH,RH_aud,SO2,SO2ChmbP,SO2ChmbT,SO2IntT,SO2LampV,SO2PMTV,SO2SampF,T640_QtTotCV,T640_TAmb,T640x_PM10L,T640x_PM10S,T640x_PM25L,T640x_QtBy,T640x_QtSample,T640x_QtTot,T640x_Tshl,TShelter,TShl,Temp_10m,Temp_2m,VOC,Vert_W_Sp_10m,WD,WD_10m,WD_S,WD_S_10m,WD_S_10m_aud,WD_S_15m,WD_S_23m,WD_S_3m,WD_S_3m_aud,WD_S_4m,WD_V,WD_V_10m,WD_V_10m_aud,WD_V_15m,WD_V_23m,WD_V_3m,WD_V_3m_aud,WD_V_4m,WS_10m,WS_S,WS_S_10m,WS_S_10m_aud,WS_S_15m,WS_S_23m,WS_S_3m,WS_S_3m_aud,WS_S_4m,WS_T,WS_T_10m,WS_T_23m,WS_T_3m,WS_V,WS_V_10m,WS_V_10m_aud,WS_V_15m,WS_V_23m,WS_V_3m,WS_V_3m_aud,WS_V_4m
"
  }
  # Default end_date_data is present datetime
  end_date_query <- lubridate::parse_date_time(end, "ymd HMS")
  end_date_data <- lubridate::parse_date_time(start, "ymd HMS")
  new_start_date <- start
  data <- NULL
  # Loop to keep querying agileweb when there are > 10k records in the date range.
  while(end_date_data < end_date_query) {
    req <- httr2::request(
      paste0(
        "https://dec.alaska.gov/applications/air/airvision/api/averagedata?",
        "sites=", stringr::str_replace(sites, " ", "%20"), "&",
        "parameters=", parameters, "&",
        "interval=", interval, "&",
        "start=", new_start_date, "&",
        "end=", end
      )
    ) |>
      httr2::req_headers("APIKEY" = api_key, .redact = "Secret") |>
      httr2::req_headers("Accept" = "text/csv")
    req
    resp <- httr2::req_perform(req) |>
      httr2::resp_body_string() |>
      readr::read_csv(show_col_types = FALSE) |>
      dplyr::select(
          "Date",
          "SiteName",
          "ParameterName",
          "ReportedUnitName",
          "IntervalName",
          "IsValid",
          "ReportValue",
          "FlagString"
      )
    data <- dplyr::bind_rows(data, resp)
    end_date_data <- max(data$Date)
    new_start_date <- agileweb_dt(max(data$Date))
    test_length <- end_date_query - end_date_data
    # Stop querying if data within 2 hours of query end.
    if(lubridate::time_length(test_length, unit = "hour") < 3) {
      break
    }
  }
  return(data)
}

#' agileweb_dt
#'
#' @param datetime Datetime in POSIXct format.
#'
#' @return Datetime in required Agileweb API format.
#' @export
#'
#' @examples
#' end <- agileweb_dt(lubridate::now())
agileweb_dt <- function(datetime) {
  aw_dt <- as.character(datetime)
  return(
    aw_dt_glued <- stringr::str_glue(
      stringr::str_sub(aw_dt, 1, 10),
      "T",
      stringr::str_sub(aw_dt, 12, 19)
    )
  )
}
