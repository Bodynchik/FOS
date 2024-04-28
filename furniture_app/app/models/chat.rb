class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :manufacturer

  has_many :messages

  def self.ransackable_associations(_auth_object = nil)
    %w[manufacturer messages user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value manufacturer_id updated_at user_id]
  end
end
