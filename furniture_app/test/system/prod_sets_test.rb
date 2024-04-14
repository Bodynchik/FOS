require 'application_system_test_case'

class ProdSetsTest < ApplicationSystemTestCase
  setup do
    @prod_set = prod_sets(:one)
  end

  test 'visiting the index' do
    visit prod_sets_url
    assert_selector 'h1', text: 'Prod sets'
  end

  test 'should create prod set' do
    visit prod_sets_url
    click_on 'New prod set'

    fill_in 'Prod data', with: @prod_set.prod_data
    fill_in 'Set name', with: @prod_set.set_name
    fill_in 'User', with: @prod_set.user_id
    click_on 'Create Prod set'

    assert_text 'Prod set was successfully created'
    click_on 'Back'
  end

  test 'should update Prod set' do
    visit prod_set_url(@prod_set)
    click_on 'Edit this prod set', match: :first

    fill_in 'Prod data', with: @prod_set.prod_data
    fill_in 'Set name', with: @prod_set.set_name
    fill_in 'User', with: @prod_set.user_id
    click_on 'Update Prod set'

    assert_text 'Prod set was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Prod set' do
    visit prod_set_url(@prod_set)
    click_on 'Destroy this prod set', match: :first

    assert_text 'Prod set was successfully destroyed'
  end
end
