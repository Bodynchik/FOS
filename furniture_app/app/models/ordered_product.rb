class OrderedProduct < ApplicationRecord
  validates :order_id, :prod_id, :prod_amount, presence: true
end
