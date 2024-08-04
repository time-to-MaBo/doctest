# test class of fars functions

testthat::test_that('fars_read and make_filename return correct class',{
  expect_s3_class(fars_read(make_filename(2013)), 'data.frame')
  expect_s3_class(fars_read(make_filename(2014)), 'data.frame')
  expect_s3_class(fars_read(make_filename(2015)), 'data.frame')
  expect_error(fars_read(make_filename(2012)))
  expect_error(make_filename('accident_2013'))
})

testthat::test_that('fars_read_years return correct value, class',{
  expect_type(fars_read_years(2013), 'list')
  expect_s3_class(fars_read_years(2014)[[1]], 'data.frame')
  expect_equal(as.numeric(fars_read_years(2015)[[1]][1,2]), 2015)
})
