require "application_system_test_case"

class FurnituresTest < ApplicationSystemTestCase
  setup do
    @furniture = furnitures(:one)
  end

  test "visiting the index" do
    visit furnitures_url
    assert_selector "h1", text: "Furnitures"
  end

  test "should create furniture" do
    visit furnitures_url
    click_on "New furniture"

    fill_in "Name", with: @furniture.name
    click_on "Create Furniture"

    assert_text "Furniture was successfully created"
    click_on "Back"
  end

  test "should update Furniture" do
    visit furniture_url(@furniture)
    click_on "Edit this furniture", match: :first

    fill_in "Name", with: @furniture.name
    click_on "Update Furniture"

    assert_text "Furniture was successfully updated"
    click_on "Back"
  end

  test "should destroy Furniture" do
    visit furniture_url(@furniture)
    click_on "Destroy this furniture", match: :first

    assert_text "Furniture was successfully destroyed"
  end
end
