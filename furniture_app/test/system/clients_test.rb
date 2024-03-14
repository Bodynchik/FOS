require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "should create client" do
    visit clients_url
    click_on "New client"

    fill_in "Client midname", with: @client.client_midname
    fill_in "Client name", with: @client.client_name
    fill_in "Client surname", with: @client.client_surname
    fill_in "Email", with: @client.email
    fill_in "Password", with: @client.password
    fill_in "Phone", with: @client.phone
    fill_in "User role", with: @client.user_role
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "should update Client" do
    visit client_url(@client)
    click_on "Edit this client", match: :first

    fill_in "Client midname", with: @client.client_midname
    fill_in "Client name", with: @client.client_name
    fill_in "Client surname", with: @client.client_surname
    fill_in "Email", with: @client.email
    fill_in "Password", with: @client.password
    fill_in "Phone", with: @client.phone
    fill_in "User role", with: @client.user_role
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "should destroy Client" do
    visit client_url(@client)
    click_on "Destroy this client", match: :first

    assert_text "Client was successfully destroyed"
  end
end
