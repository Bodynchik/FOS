class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :user
  after_commit {broadcast_append_to "room_#{room.id}"}
  after_save {broadcast_append_to "room_#{room.id}"}
  after_create_commit { broadcast_append_to "room_#{room.id}" }
end
