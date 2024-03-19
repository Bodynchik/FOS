require "application_system_test_case"

class ProdRaitingsTest < ApplicationSystemTestCase
  setup do
    @prod_raiting = prod_raitings(:one)
  end

  test "visiting the index" do
    visit prod_raitings_url
    assert_selector "h1", text: "Prod raitings"
  end

  test "should create prod raiting" do
    visit prod_raitings_url
    click_on "New prod raiting"

    fill_in "Client", with: @prod_raiting.client_id
    fill_in "Product", with: @prod_raiting.product_id
    fill_in "Raiting val", with: @prod_raiting.raiting_val
    click_on "Create Prod raiting"

    assert_text "Prod raiting was successfully created"
    click_on "Back"
  end

  test "should update Prod raiting" do
    visit prod_raiting_url(@prod_raiting)
    click_on "Edit this prod raiting", match: :first

    fill_in "Client", with: @prod_raiting.client_id
    fill_in "Product", with: @prod_raiting.product_id
    fill_in "Raiting val", with: @prod_raiting.raiting_val
    click_on "Update Prod raiting"

    assert_text "Prod raiting was successfully updated"
    click_on "Back"
  end

  test "should destroy Prod raiting" do
    visit prod_raiting_url(@prod_raiting)
    click_on "Destroy this prod raiting", match: :first

    assert_text "Prod raiting was successfully destroyed"
  end
end
