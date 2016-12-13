class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	extract_urls!(message)
    ActionCable.server.broadcast "chat_rooms_#{message.room.id}_channel",
                                 message: render_message(message)
  end

  private

  def extract_urls!(message)
    MessageParser.new(message).extract_urls!
  end

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end