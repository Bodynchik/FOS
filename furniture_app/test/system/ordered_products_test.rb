require "application_system_test_case"

class OrderedProductsTest < ApplicationSystemTestCase
  setup do
    @ordered_product = ordered_products(:one)
  end

  test "visiting the index" do
    visit ordered_products_url
    assert_selector "h1", text: "Ordered products"
  end

  test "should create ordered product" do
    visit ordered_products_url
    click_on "New ordered product"

    fill_in "Prod amount", with: @ordered_product.prod_amount
    fill_in "Product", with: @ordered_product.product_id
    click_on "Create Ordered product"

    assert_text "Ordered product was successfully created"
    click_on "Back"
  end

  test "should update Ordered product" do
    visit ordered_product_url(@ordered_product)
    click_on "Edit this ordered product", match: :first

    fill_in "Prod amount", with: @ordered_product.prod_amount
    fill_in "Product", with: @ordered_product.product_id
    click_on "Update Ordered product"

    assert_text "Ordered product was successfully updated"
    click_on "Back"
  end

  test "should destroy Ordered product" do
    visit ordered_product_url(@ordered_product)
    click_on "Destroy this ordered product", match: :first

    assert_text "Ordered product was successfully destroyed"
  end
end
