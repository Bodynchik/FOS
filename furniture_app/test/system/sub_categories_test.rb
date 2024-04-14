require 'application_system_test_case'

class SubCategoriesTest < ApplicationSystemTestCase
  setup do
    @sub_category = sub_categories(:one)
  end

  test 'visiting the index' do
    visit sub_categories_url
    assert_selector 'h1', text: 'Sub categories'
  end

  test 'should create sub category' do
    visit sub_categories_url
    click_on 'New sub category'

    fill_in 'Category', with: @sub_category.category_id
    fill_in 'Subcat name', with: @sub_category.subcat_name
    click_on 'Create Sub category'

    assert_text 'Sub category was successfully created'
    click_on 'Back'
  end

  test 'should update Sub category' do
    visit sub_category_url(@sub_category)
    click_on 'Edit this sub category', match: :first

    fill_in 'Category', with: @sub_category.category_id
    fill_in 'Subcat name', with: @sub_category.subcat_name
    click_on 'Update Sub category'

    assert_text 'Sub category was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Sub category' do
    visit sub_category_url(@sub_category)
    click_on 'Destroy this sub category', match: :first

    assert_text 'Sub category was successfully destroyed'
  end
end
