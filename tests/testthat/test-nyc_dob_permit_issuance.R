test_that("nyc_dob_permit_issuance returns a tibble and respects limits", {
  # This 'cassette' will be saved in tests/fixtures/nyc_311_test.yml
  vcr::use_cassette("nyc_dob_permit_issuance_test", {

    # We use a small limit (2) to keep the recording file small
    results <- nyc_dob_permit_issuance(limit = 2)

    # Assertions: What should be true?
    expect_s3_class(results, "tbl_df")
    expect_equal(nrow(results), 2)
  })
})

test_that("nyc_dob_permit_issuance throws errors for bad inputs", {
  # This touches the new 'stop' lines you just added
  expect_error(nyc_dob_permit_issuance(limit = "a string"))
  expect_error(nyc_dob_permit_issuance(filters = "not a list"))
})
