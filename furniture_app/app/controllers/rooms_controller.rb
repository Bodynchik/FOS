class RoomsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    favourite_categories = current_user.favorite_categories
    @rooms = Room.where(category_name: favourite_categories)
  end

  def show
    @category_name = params[:category_name]
    @room = Room.find_or_create_by(category_name: @category_name)
    @messages = @room.room_messages#.order(created_at: :desc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.find_by(name: room_params[:name])
    if @room
      redirect_to @room
    end

    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_show_path(@room.category_name), notice: 'Room was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end


  def room_params
      params.require(:room).permit()
    end

end
