class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user, optional: true
  belongs_to :manufacturer, optional: true

  def self.ransackable_associations(_auth_object = nil)
    %w[chat manufacturer user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[chat_id content created_at id id_value manufacturer_id updated_at user_id]
  end
end
