class ChatsController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
    if user_signed_in?
      @chats = Chat.where(user_id: current_user.id)
      @user_type = 'Користувач'
    else
      @chats = Chat.where(manufacturer_id: current_manufacturer.id)
      @user_type = 'Виробник'
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(created_at: :asc)
    @manufacturer = @chat.manufacturer
    @user = @chat.user
    @chat.save
    @user_type = if user_signed_in?
                   'Користувач'
                 else
                   'Виробник'
                 end
  end

  def new
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
end
