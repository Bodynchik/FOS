require "test_helper"

class SubCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_category = sub_categories(:one)
  end

  test "should get index" do
    get sub_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_category_url
    assert_response :success
  end

  test "should create sub_category" do
    assert_difference("SubCategory.count") do
      post sub_categories_url, params: { sub_category: { category_id: @sub_category.category_id, subcat_name: @sub_category.subcat_name } }
    end

    assert_redirected_to sub_category_url(SubCategory.last)
  end

  test "should show sub_category" do
    get sub_category_url(@sub_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_category_url(@sub_category)
    assert_response :success
  end

  test "should update sub_category" do
    patch sub_category_url(@sub_category), params: { sub_category: { category_id: @sub_category.category_id, subcat_name: @sub_category.subcat_name } }
    assert_redirected_to sub_category_url(@sub_category)
  end

  test "should destroy sub_category" do
    assert_difference("SubCategory.count", -1) do
      delete sub_category_url(@sub_category)
    end

    assert_redirected_to sub_categories_url
  end
end
