class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user, optional: true
  belongs_to :manufacturer, optional: true

  def self.ransackable_associations(auth_object = nil)
    ["chat", "manufacturer", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["chat_id", "content", "created_at", "id", "id_value", "manufacturer_id", "updated_at", "user_id"]
  end
end