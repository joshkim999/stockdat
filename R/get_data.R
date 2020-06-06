#' Given an interval of dates and a company's stock symbol, this function will give you the
#' opening, highest, lowest, closing, or volume stock data.
#' The function allows you to view the past 20 years of stock data.
#'
#'
#' @param from The starting date you would like to view as a string in "YYYY-MM-DD" format
#' @param to The ending date you would like to view as a string in "YYYY-MM-DD" format
#' @param stock_symbol The String of the stock symbol of a company
#' @param view_type An integer that represents 1 = open, 2 = high, 3 = low, 4 = close, or 5 = volume stock data
#' @param apikey Default is to use the apikey using the assign_apikey function. A String of the apikey
#'
#'
#' @return A dataframe of one column with the dates and another column with the stock data
#'
#' @import purrr
#' @import httr
#' @import jsonlite
#' @import lubridate
#'
#' @export
get_data <- function(from, to, stock_symbol, view_type, api_key = apikey){
  res <- GET('https://www.alphavantage.co/query?',
             query = list("function" = "TIME_SERIES_DAILY",
                          outputsize = "full",
                          symbol = stock_symbol,
                          apikey = api_key))

  data = fromJSON(rawToChar(res$content))
  by_date = data$`Time Series (Daily)`

  from_day = date(from)
  to_day = date(to)

  dates = which(date(names(by_date)) >= from_day &
                  date(names(by_date)) <= to_day)

  selected_days = by_date[dates]

  curr_data = unlist(purrr::pmap(list(date_data_frame = selected_days),
                                 .f = function(date_data_frame){
                                   return(as.numeric(date_data_frame[view_type]))
                                 }))


  curr_data_frame = data.frame(names(curr_data), curr_data)
  row.names(curr_data_frame) = 1:length(curr_data)
  names(curr_data_frame) = c("Dates", "Stock_data")
  return(curr_data_frame)
}
