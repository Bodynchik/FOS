class Category < ApplicationRecord
  has_many :sub_categories

  def self.ransackable_associations(_auth_object = nil)
    ['sub_categories']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[cat_name id id_value]
  end
end
