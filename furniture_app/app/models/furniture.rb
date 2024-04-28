class Furniture < ApplicationRecord
  has_many :products

  def self.ransackable_associations(_auth_object = nil)
    ['products']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end
end
