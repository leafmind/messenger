class RoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # TODO: cleanup
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], room_id: data['chat_room_id'])
  end
end