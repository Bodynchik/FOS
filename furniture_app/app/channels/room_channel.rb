class RoomChannel < ApplicationCable::Channel
  def subscribed
    if params[:room_id].present?
      stream_from "room_channel#{params[:room_id]}"
    else
      reject
    end
  end

  def receive(data)
    sender_id = data['sender_id']

    sender = User.find_by(id: sender_id)

    return if sender.blank?

    message_data = { username: sender.username, message: data['message'] }
    ActionCable.server.broadcast("room_channel#{params[:room_id]}", message_data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
