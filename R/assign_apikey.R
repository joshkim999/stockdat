#'
#' Allows you to use the inputted api key (from alphavantage) for this package
#'
#' @param apikey Your apikey from alphavantage as a String
#'
#'
#' @return NULL, but the apikey is saved for the usage of the package
#'
#' @export
assign_apikey <- function(apikey){
  
  stopifnot(apikey != '')
  
  assign("apikey", apikey, envir = globalenv())
}
