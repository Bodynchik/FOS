class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(message_params)

    if user_type == "Виробник"
      @message.manufacturer_id = current_manufacturer.id
    else
      @message.user_id = current_user.id
    end

    if @message.save
      render json: { message: @message }
    else
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def user_type
    params[:message][:user_type]
  end
end
