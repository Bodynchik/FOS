class SubCategory < ApplicationRecord
  validates :cat_id, :subcat_name, presence: true
end
