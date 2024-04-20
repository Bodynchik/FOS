class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products

  def self.ransackable_associations(auth_object = nil)
    ["category", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "id", "id_value", "subcat_name"]
  end
end
