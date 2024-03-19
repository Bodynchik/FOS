require "test_helper"

class ProdReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prod_review = prod_reviews(:one)
  end

  test "should get index" do
    get prod_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_prod_review_url
    assert_response :success
  end

  test "should create prod_review" do
    assert_difference("ProdReview.count") do
      post prod_reviews_url, params: { prod_review: { client_id: @prod_review.client_id, product_id: @prod_review.product_id, review_text: @prod_review.review_text } }
    end

    assert_redirected_to prod_review_url(ProdReview.last)
  end

  test "should show prod_review" do
    get prod_review_url(@prod_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_prod_review_url(@prod_review)
    assert_response :success
  end

  test "should update prod_review" do
    patch prod_review_url(@prod_review), params: { prod_review: { client_id: @prod_review.client_id, product_id: @prod_review.product_id, review_text: @prod_review.review_text } }
    assert_redirected_to prod_review_url(@prod_review)
  end

  test "should destroy prod_review" do
    assert_difference("ProdReview.count", -1) do
      delete prod_review_url(@prod_review)
    end

    assert_redirected_to prod_reviews_url
  end
end
