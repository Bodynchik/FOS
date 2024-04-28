class ProdSet < ApplicationRecord
  belongs_to :user

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value prod_data set_name updated_at user_id]
  end
end
