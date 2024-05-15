class ChatChannel < ApplicationCable::Channel
  def subscribed
    if params[:chat_id].present?
      stream_from "chat_channel_#{params[:chat_id]}"
    else
      reject
    end
  end

  def receive(data)
    sender_id = data["sender_id"]
    sender_type = data["sender_type"]

    sender_model = sender_type == "Виробник" ? Manufacturer : User
    sender = sender_model.find_by(id: sender_id)

    if sender.present?
      message_data = { username: sender.username, message: data["message"] }
      ActionCable.server.broadcast("chat_channel_#{params[:chat_id]}", message_data)
    else
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end