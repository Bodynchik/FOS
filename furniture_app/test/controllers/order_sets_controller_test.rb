require 'test_helper'

class OrderSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_set = order_sets(:one)
  end

  test 'should get index' do
    get order_sets_url
    assert_response :success
  end

  test 'should get new' do
    get new_order_set_url
    assert_response :success
  end

  test 'should create order_set' do
    assert_difference('OrderSet.count') do
      post order_sets_url,
           params: { order_set: { prodset_id: @order_set.prodset_id, total_price: @order_set.total_price } }
    end

    assert_redirected_to order_set_url(OrderSet.last)
  end

  test 'should show order_set' do
    get order_set_url(@order_set)
    assert_response :success
  end

  test 'should get edit' do
    get edit_order_set_url(@order_set)
    assert_response :success
  end

  test 'should update order_set' do
    patch order_set_url(@order_set),
          params: { order_set: { prodset_id: @order_set.prodset_id, total_price: @order_set.total_price } }
    assert_redirected_to order_set_url(@order_set)
  end

  test 'should destroy order_set' do
    assert_difference('OrderSet.count', -1) do
      delete order_set_url(@order_set)
    end

    assert_redirected_to order_sets_url
  end
end
