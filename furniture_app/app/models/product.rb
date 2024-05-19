class Product < ApplicationRecord
  belongs_to :furniture
  belongs_to :manufacturer
  belongs_to :sub_category
  has_many :orders
  has_many :comments, dependent: :destroy
  has_one_attached :product_image, dependent: :destroy
  validates :price, numericality: { greater_than: 0 }
  validates :prod_model, :production_days, presence: true
  validate :delivery_days_presence

  private

  def delivery_days_presence
    errors.add(:delivery_days, I18n.t('flash.manufacturers.errors.delivery_days')) if delivery_days.blank?
    # errors.add(:delivery_days, "must have at least one day selected") if delivery_days.blank?
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[furniture manufacturer orders sub_category]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at delivery_days description furniture_id id id_value manufacturer_id price prod_model production_days sub_category_id
       updated_at]
  end

  def average_rating
    comments.average(:rating).to_f.round(2)
  end
end
