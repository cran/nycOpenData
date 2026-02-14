test_that("nyc_civil_service_list returns a tibble and respects limits", {
  # This 'cassette' will be saved in tests/fixtures/nyc_311_test.yml
  vcr::use_cassette("nyc_civil_service_list_test", {

    # We use a small limit (2) to keep the recording file small
    results <- nyc_civil_service_list(limit = 2)

    # Assertions: What should be true?
    expect_s3_class(results, "tbl_df")
    expect_equal(nrow(results), 2)
  })
})

test_that("nyc_civil_service_list throws errors for bad inputs", {
  # This touches the new 'stop' lines you just added
  expect_error(nyc_civil_service_list(limit = "a string"))
  expect_error(nyc_civil_service_list(filters = "not a list"))
})
