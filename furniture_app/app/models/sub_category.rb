class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products

  def self.ransackable_associations(_auth_object = nil)
    %w[category products]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id id id_value subcat_name]
  end
end
