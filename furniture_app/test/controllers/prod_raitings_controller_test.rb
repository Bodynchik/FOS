require "test_helper"

class ProdRaitingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prod_raiting = prod_raitings(:one)
  end

  test "should get index" do
    get prod_raitings_url
    assert_response :success
  end

  test "should get new" do
    get new_prod_raiting_url
    assert_response :success
  end

  test "should create prod_raiting" do
    assert_difference("ProdRaiting.count") do
      post prod_raitings_url, params: { prod_raiting: { client_id: @prod_raiting.client_id, product_id: @prod_raiting.product_id, raiting_val: @prod_raiting.raiting_val } }
    end

    assert_redirected_to prod_raiting_url(ProdRaiting.last)
  end

  test "should show prod_raiting" do
    get prod_raiting_url(@prod_raiting)
    assert_response :success
  end

  test "should get edit" do
    get edit_prod_raiting_url(@prod_raiting)
    assert_response :success
  end

  test "should update prod_raiting" do
    patch prod_raiting_url(@prod_raiting), params: { prod_raiting: { client_id: @prod_raiting.client_id, product_id: @prod_raiting.product_id, raiting_val: @prod_raiting.raiting_val } }
    assert_redirected_to prod_raiting_url(@prod_raiting)
  end

  test "should destroy prod_raiting" do
    assert_difference("ProdRaiting.count", -1) do
      delete prod_raiting_url(@prod_raiting)
    end

    assert_redirected_to prod_raitings_url
  end
end
