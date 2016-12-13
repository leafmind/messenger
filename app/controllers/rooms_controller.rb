class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
