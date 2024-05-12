# require 'test_helper'
#
# class CategoryTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end


require_relative '../test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should have many sub_categories' do
    assert_respond_to Category.new, :sub_categories
  end

  test 'should be able to search by cat_name and id' do
    assert_equal %w[cat_name id id_value], Category.ransackable_attributes
  end

  test 'should be able to search through sub_categories association' do
    assert_includes Category.ransackable_associations, 'sub_categories'
  end
end
