class Category < ApplicationRecord
  has_many :sub_categories

  def self.ransackable_associations(auth_object = nil)
    ["sub_categories"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cat_name", "id", "id_value"]
  end
end
