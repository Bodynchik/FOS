class Order < ApplicationRecord
  validates :client_id, :order_date, :postcode, :order_total_val, :order_status, presence: true
end
