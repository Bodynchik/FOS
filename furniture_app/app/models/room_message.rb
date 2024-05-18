class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :user
  after_commit {broadcast_append_to "room_#{room.id}"}
  after_save {broadcast_append_to "room_#{room.id}"}
  after_create_commit { broadcast_append_to "room_#{room.id}" }

  def self.ransackable_attributes(_auth_object = nil)
    %w[body created_at id id_value room_id updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[room user]
  end
end
