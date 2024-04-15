class ChatsController < ApplicationController
  def create
    @manufacturer = Manufacturer.find(params[:manufacturer_id])
    @chat = Chat.find_by(user_id: current_user.id, manufacturer_id: @manufacturer.id)

    if @chat.present?
      redirect_to chat_path(@chat)
    else
      @chat = Chat.new(user_id: current_user.id, manufacturer_id: @manufacturer.id)
      if @chat.save
        redirect_to chat_path(@chat)
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
    @manufacturer = @chat.manufacturer
    @user = @chat.user

    if user_signed_in?
      @user_type = "Користувач"
    else
      @user_type = "Виробник"
    end
  end

end