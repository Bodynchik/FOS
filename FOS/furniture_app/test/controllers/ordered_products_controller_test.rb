require "test_helper"

class OrderedProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ordered_product = ordered_products(:one)
  end

  test "should get index" do
    get ordered_products_url
    assert_response :success
  end

  test "should get new" do
    get new_ordered_product_url
    assert_response :success
  end

  test "should create ordered_product" do
    assert_difference("OrderedProduct.count") do
      post ordered_products_url, params: { ordered_product: { prod_amount: @ordered_product.prod_amount, product_id: @ordered_product.product_id } }
    end

    assert_redirected_to ordered_product_url(OrderedProduct.last)
  end

  test "should show ordered_product" do
    get ordered_product_url(@ordered_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_ordered_product_url(@ordered_product)
    assert_response :success
  end

  test "should update ordered_product" do
    patch ordered_product_url(@ordered_product), params: { ordered_product: { prod_amount: @ordered_product.prod_amount, product_id: @ordered_product.product_id } }
    assert_redirected_to ordered_product_url(@ordered_product)
  end

  test "should destroy ordered_product" do
    assert_difference("OrderedProduct.count", -1) do
      delete ordered_product_url(@ordered_product)
    end

    assert_redirected_to ordered_products_url
  end
end
