require "application_system_test_case"

class ManufacturesTest < ApplicationSystemTestCase
  setup do
    @manufacture = manufactures(:one)
  end

  test "visiting the index" do
    visit manufactures_url
    assert_selector "h1", text: "Manufactures"
  end

  test "should create manufacture" do
    visit manufactures_url
    click_on "New manufacture"

    fill_in "Manufacture country", with: @manufacture.manufacture_country
    fill_in "Manufacture name", with: @manufacture.manufacture_name
    click_on "Create Manufacture"

    assert_text "Manufacture was successfully created"
    click_on "Back"
  end

  test "should update Manufacture" do
    visit manufacture_url(@manufacture)
    click_on "Edit this manufacture", match: :first

    fill_in "Manufacture country", with: @manufacture.manufacture_country
    fill_in "Manufacture name", with: @manufacture.manufacture_name
    click_on "Update Manufacture"

    assert_text "Manufacture was successfully updated"
    click_on "Back"
  end

  test "should destroy Manufacture" do
    visit manufacture_url(@manufacture)
    click_on "Destroy this manufacture", match: :first

    assert_text "Manufacture was successfully destroyed"
  end
end
