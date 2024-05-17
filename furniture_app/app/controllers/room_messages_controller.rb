class RoomMessagesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_room

  # def create
  #   @message = @room.room_messages.build(room_message_params)
  #   @message.room_id = params[:room_id]
  #   @message.user = current_user
  #   @message.save
  #
  # end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.room_messages.new(room_message_params)

    @message.user_id = current_user.id

    return unless @message.save

    render json: { message: @message }
  end

  private

  def room_message_params
    params.require(:message).permit(:body)
  end
end
