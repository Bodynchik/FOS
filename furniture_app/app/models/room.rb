class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_name created_at id id_value updated_at]
  end
end
