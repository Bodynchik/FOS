class Product < ApplicationRecord
  validates :subcat_id, :prod_name, :prod_price, presence: true
end
