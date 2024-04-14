require 'application_system_test_case'

class OrderSetsTest < ApplicationSystemTestCase
  setup do
    @order_set = order_sets(:one)
  end

  test 'visiting the index' do
    visit order_sets_url
    assert_selector 'h1', text: 'Order sets'
  end

  test 'should create order set' do
    visit order_sets_url
    click_on 'New order set'

    fill_in 'Prodset', with: @order_set.prodset_id
    fill_in 'Total price', with: @order_set.total_price
    click_on 'Create Order set'

    assert_text 'Order set was successfully created'
    click_on 'Back'
  end

  test 'should update Order set' do
    visit order_set_url(@order_set)
    click_on 'Edit this order set', match: :first

    fill_in 'Prodset', with: @order_set.prodset_id
    fill_in 'Total price', with: @order_set.total_price
    click_on 'Update Order set'

    assert_text 'Order set was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Order set' do
    visit order_set_url(@order_set)
    click_on 'Destroy this order set', match: :first

    assert_text 'Order set was successfully destroyed'
  end
end
