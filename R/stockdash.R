#' @title Opens Stock Recommendation Dashboard
#' @description
#' Provides the user facility to choose stocks based on Industry & Market Capilisation of the Company
#' @return 'DT" returns interactive data table of stock recommendation
#' @export
stockdash <- function() {
  app_dir <- system.file("stockdash", package = "ozstockpickr")
  shiny::runApp(app_dir, display.mode = "normal")
}
