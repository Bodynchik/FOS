class Product < ApplicationRecord
  belongs_to :furniture
  belongs_to :manufacturer
  belongs_to :sub_category
  has_many :orders
end
