class RoomsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  before_action :set_room, only: [:show, :edit, :update, :destroy, :log_index, :log_show]

  # GET /rooms
  def index
    @rooms = Room.all
    if current_user == User.first && !current_user.try(:admin?) && User.count == 1
      current_user.update_attribute :admin, true
    end
  end

  # GET /rooms/1
  def show
    @entry = Entry.new
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)

    if current_user.try(:admin?)
      if @room.save
        redirect_to @room, notice: 'Room was successfully created.'
      else
        render :new
      end
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if current_user.try(:admin?)
      if @room.update(room_params)
        redirect_to @room, notice: 'Room was successfully updated.'
      else
        render :edit 
      end
    else
      render :edit
    end
  end

  # DELETE /rooms/1
  def destroy
    if current_user.try(:admin?)
      @room.destroy
      redirect_to rooms_url, notice: 'Room was successfully destroyed.'
    else
      redirect_to rooms_url, notice: 'Room not destroyed, must be admin'
    end
  end
  
  # GET /rooms/1/logs
  def log_index
  	@entries = @room.entries
  end
  
  def log_show
  	@entry = Entry.find(params[:log_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title)
    end
end
