require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { prod_desc: @product.prod_desc, prod_is_avail: @product.prod_is_avail, prod_name: @product.prod_name, prod_price: @product.prod_price, prode_image: @product.prode_image, subcat_id: @product.subcat_id } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { prod_desc: @product.prod_desc, prod_is_avail: @product.prod_is_avail, prod_name: @product.prod_name, prod_price: @product.prod_price, prode_image: @product.prode_image, subcat_id: @product.subcat_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
