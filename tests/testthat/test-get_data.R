test_that("testing get_data", {
  apikey = "Q86JK3PHWQIELR2K"
  from = "2019-12-01"
  to = "2020-01-01"
  symbol = "IBM"
  type = 4

  curr_data = get_data(from, to, symbol, type, apikey)

  expect_equal(nrow(curr_data), 21)
  expect_equal(ncol(curr_data), 2)
})
