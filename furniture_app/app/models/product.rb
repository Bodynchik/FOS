class Product < ApplicationRecord
  belongs_to :furniture
  belongs_to :manufacturer
  belongs_to :sub_category
  has_many :orders

  def self.ransackable_associations(auth_object = nil)
    ["furniture", "manufacturer", "orders", "sub_category"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "delivery_days", "description", "furniture_id", "id", "id_value", "manufacturer_id", "price", "prod_model", "production_days", "sub_category_id", "updated_at"]
  end
end
