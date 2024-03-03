class Category < ApplicationRecord
  validates :cat_name, presence: true
end
