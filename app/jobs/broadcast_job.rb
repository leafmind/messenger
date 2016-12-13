class BroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
  	urls = URI.extract(message.body)
    ActionCable.server.broadcast "chat_rooms_#{message.room.id}_channel",
                                 message: render_message(message)
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end