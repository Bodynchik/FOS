class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def self.ransackable_associations(auth_object = nil)
    ["product", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "delivery_day", "id", "id_value", "product_id", "quantity", "total_price", "updated_at", "user_id"]
  end
end
