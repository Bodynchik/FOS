class ChatController < ApplicationController
  def index
    @user = current_user
  end
end
