# require 'minitest/autorun'
# require 'rake'
#
# class ParseTaskTest < Minitest::Test
#   def setup
#     Rake.application.rake_require "tasks/parse"
#     Rake::Task.define_task(:environment)
#   end
#
#   def test_parse_prod_name
#     task = Rake::Task["parse:prod_name"]
#     task.reenable
#
#     assert_nothing_raised do
#       task.invoke
#     end
#
#     assert_operator Category.count, :>, 0, "Expected Category.count to be greater than 0"
#     assert_operator Manufacture.count, :>, 0, "Expected Manufacture.count to be greater than 0"
#     assert_operator SubCategory.count, :>, 0, "Expected SubCategory.count to be greater than 0"
#     assert_operator Product.count, :>, 0, "Expected Product.count to be greater than 0"
#   end
# end
