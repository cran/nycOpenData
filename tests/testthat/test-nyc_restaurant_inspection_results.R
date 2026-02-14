test_that("nyc_restaurant_inspection_results returns a tibble and respects limits", {
  # This 'cassette' will be saved in tests/fixtures/nyc_311_test.yml
  vcr::use_cassette("nyc_restaurant_inspection_results_test", {

    # We use a small limit (2) to keep the recording file small
    results <- nyc_restaurant_inspection_results(limit = 2)

    # Assertions: What should be true?
    expect_s3_class(results, "tbl_df")
    expect_equal(nrow(results), 2)
  })
})

test_that("nyc_restaurant_inspection_results throws errors for bad inputs", {
  # This touches the new 'stop' lines you just added
  expect_error(nyc_restaurant_inspection_results(limit = "a string"))
  expect_error(nyc_restaurant_inspection_results(filters = "not a list"))
})
