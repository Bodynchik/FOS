class RoomsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_room, only: [:edit, :update, :destroy]
  #
  def index
    favourite_categories = current_user.favorite_categories
    @rooms = Room.where(category_name: favourite_categories)
  end

  def show
    @category_name = params[:category_name]
    @room = Room.find_or_create_by(category_name: params[:category_name])
    @messages = @room.room_messages # .order(created_at: :desc)
    @user = current_user
  end

  def create
    @room = Room.find_by(user_id: current_user.id)

    if @room.present?
      redirect_to room_path(@room)
    else
      @room = Room.new(user_id: current_user.id)
      if @room.save
        redirect_to room_path(@room)
      else
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
