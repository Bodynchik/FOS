class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def self.ransackable_associations(_auth_object = nil)
    %w[product user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at delivery_day id id_value product_id quantity total_price updated_at user_id]
  end
end
