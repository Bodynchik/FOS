class RoomMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  # def create
  #   @message = @room.room_messages.build(room_message_params)
  #   @message.room_id = params[:room_id]
  #   @message.user = current_user
  #   @message.save
  #
  # end

  def create
    @room_message = @room.room_messages.new(room_message_params)
    @room_message.user = current_user

    if @room_message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    else
      render :new
    end

  end



  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def room_message_params
    params.require(:room_message).permit(:body)
  end
end
