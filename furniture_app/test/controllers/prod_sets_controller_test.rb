require 'test_helper'

class ProdSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prod_set = prod_sets(:one)
  end

  test 'should get index' do
    get prod_sets_url
    assert_response :success
  end

  test 'should get new' do
    get new_prod_set_url
    assert_response :success
  end

  test 'should create prod_set' do
    assert_difference('ProdSet.count') do
      post prod_sets_url,
           params: { prod_set: { prod_data: @prod_set.prod_data, set_name: @prod_set.set_name,
                                 user_id: @prod_set.user_id } }
    end

    assert_redirected_to prod_set_url(ProdSet.last)
  end

  test 'should show prod_set' do
    get prod_set_url(@prod_set)
    assert_response :success
  end

  test 'should get edit' do
    get edit_prod_set_url(@prod_set)
    assert_response :success
  end

  test 'should update prod_set' do
    patch prod_set_url(@prod_set),
          params: { prod_set: { prod_data: @prod_set.prod_data, set_name: @prod_set.set_name,
                                user_id: @prod_set.user_id } }
    assert_redirected_to prod_set_url(@prod_set)
  end

  test 'should destroy prod_set' do
    assert_difference('ProdSet.count', -1) do
      delete prod_set_url(@prod_set)
    end

    assert_redirected_to prod_sets_url
  end
end
