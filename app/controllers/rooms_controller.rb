class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end
  
end
