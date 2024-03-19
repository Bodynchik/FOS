require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "should create payment" do
    visit payments_url
    click_on "New payment"

    fill_in "Order", with: @payment.order_id
    fill_in "Payment date", with: @payment.payment_date
    fill_in "Payment method", with: @payment.payment_method
    fill_in "Payment status", with: @payment.payment_status
    fill_in "Transaction", with: @payment.transaction_id
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "should update Payment" do
    visit payment_url(@payment)
    click_on "Edit this payment", match: :first

    fill_in "Order", with: @payment.order_id
    fill_in "Payment date", with: @payment.payment_date
    fill_in "Payment method", with: @payment.payment_method
    fill_in "Payment status", with: @payment.payment_status
    fill_in "Transaction", with: @payment.transaction_id
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment" do
    visit payment_url(@payment)
    click_on "Destroy this payment", match: :first

    assert_text "Payment was successfully destroyed"
  end
end
