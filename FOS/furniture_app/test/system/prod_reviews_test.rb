require "application_system_test_case"

class ProdReviewsTest < ApplicationSystemTestCase
  setup do
    @prod_review = prod_reviews(:one)
  end

  test "visiting the index" do
    visit prod_reviews_url
    assert_selector "h1", text: "Prod reviews"
  end

  test "should create prod review" do
    visit prod_reviews_url
    click_on "New prod review"

    fill_in "Client", with: @prod_review.client_id
    fill_in "Product", with: @prod_review.product_id
    fill_in "Review text", with: @prod_review.review_text
    click_on "Create Prod review"

    assert_text "Prod review was successfully created"
    click_on "Back"
  end

  test "should update Prod review" do
    visit prod_review_url(@prod_review)
    click_on "Edit this prod review", match: :first

    fill_in "Client", with: @prod_review.client_id
    fill_in "Product", with: @prod_review.product_id
    fill_in "Review text", with: @prod_review.review_text
    click_on "Update Prod review"

    assert_text "Prod review was successfully updated"
    click_on "Back"
  end

  test "should destroy Prod review" do
    visit prod_review_url(@prod_review)
    click_on "Destroy this prod review", match: :first

    assert_text "Prod review was successfully destroyed"
  end
end
