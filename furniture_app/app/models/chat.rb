class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :manufacturer

  has_many :messages

  def self.ransackable_associations(auth_object = nil)
    ["manufacturer", "messages", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "manufacturer_id", "updated_at", "user_id"]
  end
end
