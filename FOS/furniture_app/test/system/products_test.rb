require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Manufacture", with: @product.manufacture_id
    fill_in "Prod avail amount", with: @product.prod_avail_amount
    fill_in "Prod desc", with: @product.prod_desc
    fill_in "Prod name", with: @product.prod_name
    fill_in "Prod price", with: @product.prod_price
    fill_in "Prod raiting", with: @product.prod_raiting
    fill_in "Sub category", with: @product.sub_category_id
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Manufacture", with: @product.manufacture_id
    fill_in "Prod avail amount", with: @product.prod_avail_amount
    fill_in "Prod desc", with: @product.prod_desc
    fill_in "Prod name", with: @product.prod_name
    fill_in "Prod price", with: @product.prod_price
    fill_in "Prod raiting", with: @product.prod_raiting
    fill_in "Sub category", with: @product.sub_category_id
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
