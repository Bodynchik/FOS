class Product < ApplicationRecord
  belongs_to :furniture
  belongs_to :manufacturer
  belongs_to :sub_category
  has_many :orders
  has_many :comments, dependent: :destroy
  has_one_attached :product_image, dependent: :destroy

  def self.ransackable_associations(_auth_object = nil)
    %w[furniture manufacturer orders sub_category]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at delivery_days descriptions furniture_id id id_value manufacturer_id price prod_model production_days sub_category_id
       updated_at]
  end

  def average_rating
    comments.average(:rating).to_f.round(2)
  end
end
