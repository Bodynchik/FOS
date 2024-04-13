class ChatChannel < ApplicationCable::Channel
  def subscribed
    user_id = params[:user_id]
    if user_id.present?
      stream_from "chat_channel"
      logger.info "User #{user_id} subscribed to chat channel"
    else
      reject
    end
  end

  def receive(data)
    user = User.find(params[:user_id])
    message_data = { username: user.username, message: data['message'] }
    ActionCable.server.broadcast("chat_channel", message_data)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
